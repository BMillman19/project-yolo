var crypto = require('crypto')
  , bcrypt = require('bcrypt');

// Returns hexadecimal hash of a string
exports.hash = function (str) {
  return crypto.createHash('sha1').update(str).digest('hex');
}

// Generates a token and expiration to return to the client
// sha1(username + timestamp)
exports.genClientToken = function (username) {
  var time = new Date();
  return {
    token: this.hash(username + time),
    expiration: new Date().setHours(time.getHours() + app.settings.config.sessionTimeout)
  }
}

// After generating a client token, rehash it with the secret
// sha1(sha1(username + timestamp))
// @NOTE: This is what we store in the DB and authenticate against
exports.genSessionToken = function (clientToken) {
  return this.hash(clientToken + app.settings.config.secret);
}

// Encrypts string using bcrypt
exports.bcrypt = function (str, rounds) {
  rounds = existsOrElse(rounds, app.settings.config.bcryptRounds);
  return bcrypt.hashSync(str, rounds);
}

// Checks cleartext password against bcrypt'd password
exports.checkPassword = function (pass, encrypted) {
  return bcrypt.compareSync(pass, encrypted);
}

