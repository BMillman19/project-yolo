var config = {};

config.development = {
  scripts: {
    libs: [
      'javascripts/vendor/underscore.js',
      'javascripts/vendor/backbone.js'
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