
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
  var mail = require('../lib/mail');
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
    if (!err) {
      res.send(resStatus);
    }
  });
};
