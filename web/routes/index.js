
/*
 * GET home page.
 */

exports.index = function (req, res) {
  res.render('index', {
    title: 'Express',
    stylesheets: app.settings.stylesheets,
    scripts: app.settings.scripts,
    templates: app.settings.templates
  });
};

exports.notif = function (req, res) {
  var params = req.body
    , apnConn = new apn.Connection(app.settings.apn)
    , device = new apn.Device(params.to)
    , notif = new apn.Notification();

  notif.expiry = Math.floor(Date.now() / 1000) + 3600; // Expires 1 hour from now.
  notif.alert = params.message;
  notif.payload = {'messageFrom': 'PromptU'};
  notif.device = device;

  apnConn.sendNotification(notif);
  res.send(202);
  /*var mail = require('../lib/mail');
  mail.send({
    to: req.body.to,
    data: {
      subject: 'test',
      header_image: 'blah',
      tw_profile_link: 'blah',
      fb_profile_link: 'blah',
      year: 'blah',
      company_name: 'blah',
      unsub_link: 'blah',
      update_profile_link: 'blah'
    }
  }, function (err, resStatus) {
    if (err) { exception.sendE(res, 'MAIL_EXCEPTION', err); return; }
    res.send(resStatus);
  });*/
};
