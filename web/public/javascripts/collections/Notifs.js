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
    },
    search: function (query) {
      return this.filter(function (notif) {
        return notif.get('header').indexOf(query) >= 0 ||
          notif.get('body').indexOf(query) >= 0 ||
          _.any(notif.get('tags'), function (tag) {
            return tag.indexOf(query) >= 0;
          });
      });
    }
  });

  PUApp.collections.Notifs = Notifs;
}(window, $, _, Backbone, PUApp));