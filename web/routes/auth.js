var crypto = require('../lib/crypto')
  , exception = require('../lib/exception');

/**
 * GET /auth
 * @param req req.params should equal {email: ..., password: ...}
 * @param res the response that will be returned
 */
exports.auth = function (req, res) {
  var params = req.query;

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
  Models.User.find({
    email: params.email.toLowerCase(),
  }, function (err, data) {
    var user = data[0];
    if (!err) {
      // If user exists and password matches, send client session token
      if (data.length > 0 &&
          crypto.checkPassword(params.password, user.password)) {
        var token = crypto.genClientToken(params.email);
        updateDbSessionToken(user._id, token);
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
  params = _.pick(params,
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
  Models.User.find({
    email: params.email.toLowerCase()
  }, function (err, data) {
    if (!err) {
      if (data.length === 0) {
        var user = new Models.User(params);
        // TODO: do validation here
        user.save(function (err) {
          if (err) {
            exception.sendE(res, 'VALIDATION_EXCEPTION', err.errors);
          } else {
            res.send(201);
          }
        });
      } else {
        exception.sendE(res, 'SIGNUP_EXCEPTION');
      }
    }
  });
}


