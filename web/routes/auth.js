/**
 * GET /auth
 * @param req req.params should equal {username: ..., password:
 * ...}
 * @param res the response that will be returned
 */
exports.auth = function (req, res) {
  var params = req.query
    , crypto = require('../lib/crypto');

  // Updates a user's session in the database
  var updateDbSessionToken = function (userid, clientToken) {
    var query = {_id: userid}
      , change = {session: crypto.genSessionToken(clientToken)};
    Models.User.update(query, {$set: change}, {}, function (err) {
      if (err) {
        console.log(err);
        res.send(500);
      }
    });
  };

  // Look for username and password combo
  Models.User.find({
    username: params.username,
  }, function (err, data) {
    var user = data[0];
    if (!err) {
      if (data.length > 0 &&
          crypto.checkPassword(params.password, user.password)) {
        var token = crypto.genClientToken(params.username);
        updateDbSessionToken(user._id, token);
        res.send(token);
      } else {
        res.send(403, 'Authentication credentials were invalid.');
      }
    } else {
      console.log(err);
      res.send(500);
    }
  });
}

exports.signup = function (req, res) {
  var params = req.body
    , crypto = require('../lib/crypto')
    , _ = require('underscore');

  // Filter query relevant keys
  // TODO: validation on these params
  params = _.pick(params,
    'username',
    'password',
    'email',
    'phone',
    'preferences',
    'associations'
  );
  params.password = crypto.bcrypt(params.password);

  Models.User.find({
    username: params.username
  }, function (err, data) {
    if (!err) {
      if (data.length === 0) {
        var user = new Models.User(params);
        user.save(function (err) {
          if (err) {
            console.log(err);
            res.send(500);
          } else {
            res.send(201);
          }
        });
      } else {
        res.send(409, 'Username already taken.')
      }
    }
  });
}


