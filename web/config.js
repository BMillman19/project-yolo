var config = {};

config.development = {
  stylesheets: [
    'stylesheets/bootstrap-responsive.css',
    'stylesheets/bootstrap.css'
  ],
  scripts: {
    libs: [
      // 'javascripts/vendor/jquery-1.7.2.js',
      'javascripts/vendor/underscore.js',
      'javascripts/vendor/backbone.js'
    ],
    models: [
      'javascripts/models/Notif.js'
    ],
    views: [
      'javascripts/views/NotifsView.js'
    ],
    collections: [
      'javascripts/collections/Notifs.js'
    ],
    controllers: [
      'javascripts/controllers/Router.js'
    ],
    bootstrap: [
      'javascripts/vendor/bootstrap/bootstrap.js',
      'javascripts/vendor/bootstrap/alert.js',
      'javascripts/vendor/bootstrap/button.js',
      'javascripts/vendor/bootstrap/carousel.js',
      'javascripts/vendor/bootstrap/collapse.js',
      'javascripts/vendor/bootstrap/dropdown.js',
      'javascripts/vendor/bootstrap/modal.js',
      'javascripts/vendor/bootstrap/popover.js',
      'javascripts/vendor/bootstrap/scrollspy.js',
      'javascripts/vendor/bootstrap/tab.js',
      'javascripts/vendor/bootstrap/tooltip.js',
      'javascripts/vendor/bootstrap/transition.js',
      'javascripts/vendor/bootstrap/typeahead.js'
    ]
  },
  email: {
    transport: {
      service: "Gmail",
      auth: {
        user: "promptuapp@gmail.com",
        pass: "6mbTkYe8uXcc"
      }
    },
    defaults: {
      sender: 'promptU App <notifier@promptuapp.com>',
      subject: 'New Notification from promptU',
      template: 'templates/email.html'
    }
  }
};

config.production = {
  stylesheets: [
    'stylesheets/bootstrap-responsive.min.css',
    'stylesheets/bootstrap.min.css',
    'style.css'
  ],
  scripts: {
    libs: [
      'javascripts/vendor/underscore.min.js',
      'javascripts/vendor/backbone.min.js'
    ]
  }
};

config.universal = {
  secret: 'eUWEUVYKRvfxMaZNgY4Q7eWV',
  sessionTimeout: 4,
  bcryptRounds: 10
};

module.exports = config;
