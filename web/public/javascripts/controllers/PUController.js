(function (window, $, _, Backbone, PUApp) {
  var Router = Backbone.Router.extend({
    routes: {
      '' : 'init',
      '*other': 'redirect'
    },
    init: function () {

    },
    redirect: function () {

    }
  });

  PUApp.controllers.Router = Router;
}(window, $, _, Backbone, PUApp));