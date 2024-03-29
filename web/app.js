var express = require('express')
  , fs = require('fs')
  , http = require('http')
  , sys = require('sys')
  , exec = require('child_process').exec
  , config = require('./config');

// Globals
_ = require('underscore')
  , exception = require('./lib/exception')
  , exists = function (any) { return (typeof any !== 'undefined'); }
  , existsOrElse = function (any, alt) { return exists(any) ? any : alt; };

// Set up mongoose with MongoDB
mongoose = require('mongoose');
mongoose.connect(process.env.PROMPTU_MONGO_URI || 'mongodb://localhost/promptu');
Models = require('./models/models');

// Options for Apple Push Notifications
apn = require('apn');
var certConf = config.universal.apn.cert
  , apnOpts = _.chain(certConf)
    .pick('passphrase')
    .extend(config.universal.apn.options, {
      certData: fs.readFileSync(certConf.path + certConf.cert),
      keyData: fs.readFileSync(certConf.path + certConf.key),
      //ca: fs.readFileSync(certConf.path + certConf.ca),
    })
    .value();

var puts = function (error, stdout, stderr) {
  sys.puts(stdout);
  sys.puts(stderr);
};
_.chain(fs.readdirSync('public/stylesheets/'))
  .filter(function (file) {
    // return (/^[a-zA-Z0-9\-_\.]+\.less/).test(file);
    return (/^style\.less/).test(file);
  })
  .each(function (file) {
    var path = __dirname + '/public/stylesheets/'
      , cmd = 'lessc ' + path + file + ' > ' + path + file.replace('less', 'css');
    exec(cmd, puts);
  });

app = express();

app.configure(function () {
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.set('models', require('./models/models'));
  app.set('config', config.universal);
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

config.templates = _.chain(fs.readdirSync('templates'))
  .filter(function (file) {
    return (/^[\w\-\.]+\.html$/).test(file);
  })
  .reduce(function (memo, file) {
    console.log('Loading template ' + file);
    memo[file.slice(0, -5)] = fs.readFileSync('templates/' + file).toString();
    return memo;
  }, {})
  .value();

// Load all routes in ./routes/
var routes = _.chain(fs.readdirSync('routes/'))
  .filter(function (file) {
    return (/^[\w\-\.]+\.js$/).test(file);
  })
  .reduce(function (memo, file) {
    console.log('Loading route ' + file);
    var newRoute = require('./routes/' + file.slice(0, -3));
    return _.extend(memo, newRoute);
  }, {})
  .value();

app.set('templates', config.templates);
app.configure('development', function () {
  app.set('stylesheets', config.development.stylesheets);
  app.set('scripts', config.development.scripts);
  app.set('email', config.development.email);
  app.set('apn', _(apnOpts).extend({
    gateway: config.development.apnGateway
  }));
  app.use(express.errorHandler());
});

app.configure('production', function () {
  app.set('scripts', config.production.scripts);
  app.set('email', config.development.email);
  app.set('apn', _(apnOpts).extend({
    gateway: config.production.apnGateway
  }));
});

// ROUTES
app.get('/', routes.index);
app.post('/auth', routes.auth);
app.post('/signup', routes.signup);

app.get('/group/:id', routes.getGroup);
app.get('/group/tree/:id', routes.getGroupTree);
app.post('/group/create', routes.createGroup);
app.del('/group/delete/:id', routes.deleteGroup);

app.post('/notif', routes.notif);


http.createServer(app).listen(app.get('port'), function () {
  console.log("Express server listening on port " + app.get('port'));
});
