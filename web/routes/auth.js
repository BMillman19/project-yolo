var crypto = require('../lib/crypto');

/**
 * GET /auth
 * @param req req.body should equal {email: ..., password: ...}
 * @param res the response that will be returned
 */
exports.auth = function (req, res) {
  var params = req.body;

  // Updates a user's session in the database
  var updateDbSessionToken = function (userid, clientToken) {
    var query = {_id: userid}
      , change = {session: crypto.genSessionToken(clientToken)};
    Models.User.update(query, {$set: change}, {}, function (err) {
      if (err) {
        exception.sendUnkE(res, err);
      }
    });
  };

  // Look for email and password combo
  Models.User.findOne({
    email: params.email.toLowerCase(),
  }, function (err, data) {
    if (!err) {
      // If user exists and password matches, send client session token
      if (data && crypto.checkPassword(params.password, data.password)) {
        var token = crypto.genClientToken(params.email);
        updateDbSessionToken(data._id, token);
        res.send(token);
      } else {
        exception.sendE(res, 'INVALID_CREDENTIALS');
      }
    } else {
      exception.sendUnkE(res, err);
    }
  });
}

/**
 * POST /signup
 * @param req req.body should contain at minimum email and password
 * @param res the response that will be returned
 */
exports.signup = function (req, res) {
  var params = req.body;

  // Filter query relevant keys
  params = _(params).pick(
    'email',
    'password',
    'phone',
    'preferences',
    'associations'
  );

  if (!exists(params.email) || !exists(params.password)){
    exception.sendE(res, 'VALIDATION_EXCEPTION', 'Missing either email or password');
    return false;
  }
  // Validate password
  if (!/^[\w\W]{7,32}$/.test(params.password)) {
    exception.sendE(res, 'VALIDATION_EXCEPTION', 'Invalid password');
    return false;
  }

  // Encrypt password using bcrypt
  params.password = crypto.bcrypt(params.password);

  // Look for existing user with same username (email)
  Models.User.findOne({
    email: params.email.toLowerCase()
  }, function (err, data) {
    if (err) { exception.sendUnkE(res, err); return; }
    if (data) { exception.sendE(res, 'SIGNUP_EXCEPTION'); return; }
    // Create new user
    var now = Date.now()
      , userParams = _.extend(
        {},
        params,
        {created: now, updated: now}
      )
      , user = new Models.User(userParams);
    user.save(function (err) {
      if (err) {
        exception.sendE(res, 'VALIDATION_EXCEPTION', err.errors);
      } else {
        res.send(201);
      }
    });
  });
}


