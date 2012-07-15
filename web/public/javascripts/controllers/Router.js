(function (window, $, _, Backbone, PUApp) {
  var Notif = PUApp.models.Notif,
    Notifs = PUApp.collections.Notifs,
    NotifsView = PUApp.views.NotifsView;

  var Router = Backbone.Router.extend({
    routes: {
      '' : 'init',
      '*other': 'redirect'
    },
    init: function () {
      var notifs = new Notifs();
      var notifsview = new NotifsView({
        model: notifs
      });
      $('#notifs').append(notifsview.$el);

      notifs.add([
        { header: 'test', body: 'yolo', tags: [] },
        { header: 'test2', body: 'yolo', tags: [] },
        { header: 'test3', body: 'yolo', tags: [] },
        { header: 'test4', body: 'yolo', tags: [] }
      ]);

      notifsview.render();
    },
    redirect: function () {

    }
  });

  PUApp.controllers.Router = Router;
}(window, $, _, Backbone, PUApp));