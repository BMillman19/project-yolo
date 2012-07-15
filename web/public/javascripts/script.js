var PUApp = {
  models: {},
  views: {},
  collections: {},
  controllers: {},
  config: {}
};

$(document).ready(function () {
  var router = new PUApp.controllers.Router();
  Backbone.history.start();
  router.navigate();
});