(function (window, $, _, Backbone, PUApp) {
  var NotifView = PUApp.views.NotifView;
  var NotifsView = Backbone.View.extend({
    tagName: 'div',
    className: 'notifs',
    initialize: function () {
      this.model = this.options.model;
      this.model
        .on('add', _.bind(this.addNotif, this));
      this.subviews = {};
      this.resetSelection();
    },
    events: {
      'click .notif-tag': 'clickHandler'
    },
    clickHandler: function (e) {
      var tagName = $(e.target).html();
      this.model.each(_.bind(function (model) {
        if (!_.include(model.get('tags'), tagName)) {
          this.subviews[model.cid].$el.hide();
        }
      }, this));
    },
    resetSelection: function () {
      this.model.each(_.bind(function (model) {
        this.subviews[model.cid].$el.show();
      }, this));
    },
    addNotif: function (notifModel) {
      var view = new NotifView({
          model: notifModel
      });
      this.$el.append(view.render().$el);
      this.subviews[notifModel.cid] = view;
    },
    render: function () {
      _.each(this.model.models, _.bind(function (userModel) {
        this.subviews[userModel.cid].render();
      }, this));
    }
  });

  PUApp.views.NotifsView = NotifsView;
}(window, $, _, Backbone, PUApp));