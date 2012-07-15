(function (window, $, _, Backbone, PUApp) {
  var Notif = PUApp.models.Notif;
  var Notifs = Backbone.Collection.extend({
    model: Notif,
    initialize: function () {
    }
  });

  PUApp.collections.Notifs = Notifs;
}(window, $, _, Backbone, PUApp));