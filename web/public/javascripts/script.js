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

  $(document).keyup(function(e) {
    if (e.keyCode == 27) {
      router.resetSelection();
    }
  });
});
