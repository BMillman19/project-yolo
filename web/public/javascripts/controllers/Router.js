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
      this.notifs = new Notifs();
      this.notifsview = new NotifsView({
        model: this.notifs
      });
      $('#notifs').append(this.notifsview.$el);

      this.notifs.add([
        { header: 'test', body: 'yolo', tags: ['aaa'] },
        { header: 'test2', body: 'yolo', tags: ['bbb'] },
        { header: 'test3', body: 'yolo', tags: ['aaa'] },
        { header: 'test', body: 'yolo', tags: [] },
        { header: 'test2', body: 'yolo', tags: ['aaa'] },
        { header: 'test3', body: 'yolo', tags: [] },
        { header: 'test', body: 'yolo', tags: [] },
        { header: 'test2', body: 'yolo', tags: ['aaa'] },
        { header: 'test3', body: 'yolo', tags: [] },
        { header: 'test', body: 'yolo', tags: ['bbb'] },
        { header: 'test2', body: 'yolo', tags: [] },
        { header: 'test3', body: 'yolo', tags: [] },
        { header: 'test', body: 'yolo', tags: ['bbb'] },
        { header: 'test2', body: 'yolo', tags: [] },
        { header: 'test3', body: 'yolo', tags: ['bbb'] },
        { header: 'test', body: 'yolo', tags: [] },
        { header: 'test2', body: 'yolo', tags: [] },
        { header: 'test3', body: 'yolo', tags: [] },
        { header: 'test', body: 'yolo', tags: [] },
        { header: 'test2', body: 'yolo', tags: [] },
        { header: 'test3', body: 'yolo', tags: [] },
        { header: 'test4', body: 'yolo', tags: [] }
      ]);

      this.notifsview.render();
    },
    redirect: function () {

    },
    resetSelection: function () {
      this.notifsview.resetSelection();
    }
  });

  PUApp.controllers.Router = Router;
}(window, $, _, Backbone, PUApp));