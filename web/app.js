var express = require('express')
  , fs = require('fs')
  , http = require('http')
  , lessMiddleware = require('less-middleware')
  , _ = require('underscore')
  , routes = require('./routes')
  , config = require('./config');

app = express();

app.configure(function () {
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  // app.use(lessMiddleware({
  //   src: __dirname + '/public',
  //   compress: true
  // }));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

config.templates = _.chain(fs.readdirSync('templates'))
  .filter(function (file) {
    return (/^[a-zA-Z0-9\-_\.]+\.html/).test(file);
  })
  .reduce(function (memo, file) {
    memo[file.slice(0, -5)] = fs.readFileSync('templates/' + file).toString();
    return memo;
  }, {})
  .value();

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
