
/*
 * GET home page.
 */

exports.index = function (req, res) {
  res.render('index', {
    title: 'Express',
    scripts: app.settings.scripts
  });
};