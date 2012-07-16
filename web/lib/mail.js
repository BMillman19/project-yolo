module.exports = (function () {
  var emailConfig = app.settings.email
    , mailer      = require('nodemailer')
    , _           = require('underscore');
  var transport;

  return {
    init: function (override) {
      transport = mailer.createTransport('SMTP', override || emailConfig.transport);
    },

    send: function (options, callback) {
      // If no transport is defined, call initialize
      if (typeof transport === 'undefined') this.init();
      var combinedOpts = _(emailConfig.options).extend(options);
      transport.sendMail(combinedOpts, callback);
    }
  };

}());
