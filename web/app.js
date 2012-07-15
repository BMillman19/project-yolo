var express = require('express')
  , fs = require('fs')
  , http = require('http')
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
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

_.each(['models', 'views', 'collections', 'controllers'], function (dir) {
  var path = __dirname + '/public/javascripts/' + dir;
  config.development.scripts[dir] = _.chain(fs.readdirSync(path))
    .filter(function (file) {
      return (/^[a-zA-Z0-9-_\.]+\.js/).test(file);
    })
    .map(function (file) {
      return '/javascripts/' + dir + '/' + file;
    })
    .value();
});

app.configure('development', function () {
  app.set('scripts', config.development.scripts);
  app.use(express.errorHandler());
});

app.configure('production', function () {
  app.set('scripts', config.production.scripts);
});


// ROUTES
app.get('/', routes.index);


http.createServer(app).listen(app.get('port'), function () {
  console.log("Express server listening on port " + app.get('port'));
});
