
/*
 * GET home page.
 */

exports.index = function (req, res) {
  res.render('index', {
    title: 'Express',
    scripts: app.settings.scripts,
    templates: app.settings.templates
  });
};

exports.notif = function (req, res) {
  var mail = require('../lib/mail');
  mail.send({
    to: req.body['to'],
    text: 'Hello World',
    html: '<b>Hello World</b>'
  }, function (err, resStatus) {
    if (!err)
      res.send(resStatus);
  });
}
