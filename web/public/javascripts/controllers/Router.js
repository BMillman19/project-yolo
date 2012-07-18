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

    }
  });

  PUApp.controllers.Router = Router;


  var router = new PUApp.controllers.Router();
  $(document).ready(function () {
    Backbone.history.start();
    router.navigate();
  }).keyup(function (e) {
    if (e.keyCode === 27 && router.notifsview) {
      router.notifsview.resetSelection();
    }
  }).on('keyup', 'input[type=text].search-box', _.throttle(function (e) {
    var input = $(e.currentTarget).attr('value');
    router.notifsview.search(input);
  }, 10));

}(window, $, _, Backbone, PUApp));