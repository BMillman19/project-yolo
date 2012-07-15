var config = {};

config.development = {
  scripts: [
    'vendor/underscore.js',
    'vendor/backbone.js'
  ]
};

config.production = {
  scripts: [
    'vendor/underscore.js',
    'vendor/backbone.js'
  ]
};

config.secret = 'eUWEUVYKRvfxMaZNgY4Q7eWV';
config.sessionTimeout = 4; // hours


module.exports = config;