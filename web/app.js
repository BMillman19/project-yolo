var express = require('express')
  , fs = require('fs')
  , http = require('http')
  , sys = require('sys')
  , exec = require('child_process').exec
  , _ = require('underscore')
  , routes = require('./routes')
  , config = require('./config');

var puts = function (error, stdout, stderr) {
  sys.puts(stdout);
  sys.puts(stderr);
};
_.chain(fs.readdirSync('public/stylesheets/'))
  .filter(function (file) {
    // return (/^[a-zA-Z0-9\-_\.]+\.less/).test(file);
    return (/^style.less/).test(file);
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
    console.log('Loading template ' + file)
    memo[file.slice(0, -5)] = fs.readFileSync('templates/' + file).toString();
    return memo;
  }, {})
  .value();

// Load all routes in ./routes/
routes = _.chain(fs.readdirSync('routes/'))
  .filter(function (file) {
    return (/^[\w\-\.]+\.js$/).test(file) && !(/^index\.js$/).test(file);
  })
  .reduce(function (memo, file) {
    console.log('Loading route ' + file);
    var newRoute = require('./routes/' + file.slice(0, -3));
    return _.extend(memo, newRoute);
  }, routes);

app.set('templates', config.templates);
app.configure('development', function () {
  app.set('stylesheets', config.development.stylesheets);
  app.set('scripts', config.development.scripts);
  app.set('email', config.development.email);
  app.use(express.errorHandler());
});

app.configure('production', function () {
  app.set('scripts', config.production.scripts);
});


// ROUTES
app.get('/', routes.index);
app.post('/notif', routes.notif);


http.createServer(app).listen(app.get('port'), function () {
  console.log("Express server listening on port " + app.get('port'));
});
