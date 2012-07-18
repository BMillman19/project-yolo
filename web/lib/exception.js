var exceptions = {
  API_EXCEPTION: {
    code: 500,
    msg: 'Unknown API exception'
  },
  INVALID_CREDENTIALS: {
    code: 403,
    msg: 'Invalid authorization credentials'
  },
  VALIDATION_EXCEPTION: {
    code: 400,
    msg: 'Malformed inputs'
  },
  SIGNUP_EXCEPTION: {
    code: 409,
    msg: 'Could not create user because user already exists'
  }
}

module.exports = _.extend({}, exceptions, {
  // Sends an exception as an HTTP response
  sendE: function (res, e, info) {
    var exception = this[e] || this.API_EXCEPTION;

    console.log("Exception in API", exception, {info: info});

    if (exists(exception)) {
      if (exists(info)) exception.info = info;
      res.json(exception, exception.code);
    }
  },

  // Easier method call to send an exception when you don't know the
  // type
  sendUnkE: function (res, info) { this.sendE(res, null, info) }
});

