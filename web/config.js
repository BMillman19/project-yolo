var config = {};

config.development = {
  scripts: {
    libs: [
      'javascripts/vendor/underscore.js',
      'javascripts/vendor/backbone.js'
    ],
    models: [
      'javascripts/models/Notif.js'
    ],
    views: [
      'javascripts/views/NotifView.js',
      'javascripts/views/NotifsView.js'
    ],
    collections: [
      'javascripts/collections/Notifs.js'
    ],
    controllers: [
      'javascripts/controllers/Router.js'
    ]
  }
};

config.production = {
  scripts: {
    libs: [
      'javascripts/vendor/underscore.min.js',
      'javascripts/vendor/backbone.min.js'
    ]
  }
};

config.secret = 'eUWEUVYKRvfxMaZNgY4Q7eWV';
config.sessionTimeout = 4; // hours

module.exports = config;