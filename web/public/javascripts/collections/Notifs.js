(function (window, $, _, Backbone, PUApp) {
  var Notif = PUApp.models.Notif;
  var Notifs = Backbone.Collection.extend({
    model: Notif,
    initialize: function () {
    },
    filterByTag: function (tag) {
      return this.filter(function (notif) {
        return _.include(notif.get('tags'), tag);
      });
    }
  });

  PUApp.collections.Notifs = Notifs;
}(window, $, _, Backbone, PUApp));