module.exports = (function () {
  var email = app.settings.email
    , mailer = require('nodemailer')
    , _ = require('underscore')
    , fs = require('fs');
  var transport;

  // Convert template from path to Underscore template
  var template = _.template(fs.readFileSync(email.defaults.template).toString());

  return {
    init: function (override) {
      transport = mailer.createTransport('SMTP', override || email.transport);
    },

    send: function (options, callback) {
      // If no transport is defined, call initialize
      if (exists(transport)) this.init();
      var combinedOpts = _.defaults(options, email.defaults);
      combinedOpts.html = template(options.data);
      transport.sendMail(combinedOpts, callback);
    }
  };

}());
