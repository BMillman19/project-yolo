(function (window, $, _, Backbone, PUApp) {
  var Notif = PUApp.models.Notif;
  var Notifs = Backbone.Collection.extend({
    model: Notif,
    initialize: function () {
      this.on('add', _.bind(this.addNotif, this));
    },
    addNotif: function (notif) {

    }
  });

  PUApp.collections.Notifs = Notifs;
}(window, $, _, Backbone, PUApp));