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
        { priority: 0, header: 'test', body: 'yolo', tags: ['aaa'] },
        { priority: 1, header: 'test2', body: 'yolo', tags: ['bbb'] },
        { priority: 2, header: 'test3', body: 'yolo', tags: ['aaa'] },
        { priority: 3, header: 'test', body: 'yolo', tags: [] },
        { priority: 1, header: 'test2', body: 'yolo', tags: ['aaa'] },
        { priority: 2, header: 'test3', body: 'yolo', tags: [] },
        { priority: 1, header: 'test', body: 'yolo', tags: [] },
        { priority: 1, header: 'test2', body: 'yolo', tags: ['aaa'] },
        { priority: 2, header: 'test3', body: 'yolo', tags: [] },
        { priority: 3, header: 'test', body: 'yolo', tags: ['bbb'] },
        { priority: 0, header: 'test2', body: 'yolo', tags: [] },
        { priority: 1, header: 'test3', body: 'yolo', tags: [] },
        { priority: 2, header: 'test', body: 'yolo', tags: ['bbb'] },
        { priority: 3, header: 'test2', body: 'yolo', tags: [] },
        { priority: 0, header: 'test3', body: 'yolo', tags: ['bbb'] },
        { priority: 1, header: 'test', body: 'yolo', tags: [] },
        { priority: 2, header: 'test2', body: 'yolo', tags: [] },
        { priority: 3, header: 'test3', body: 'yolo', tags: [] },
        { priority: 0, header: 'test', body: 'yolo', tags: [] },
        { priority: 1, header: 'test2', body: 'yolo', tags: [] },
        { priority: 1, header: 'test3', body: 'yolo', tags: [] },
        { priority: 1, header: 'test4', body: 'yolo', tags: [] }
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