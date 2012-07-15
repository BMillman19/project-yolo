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
    },
    events: {
      'click': 'clickHandler'
    },
    clickHandler: function (e) {

    },
    addNotif: function (notifModel) {
      this.subviews[notifModel.cid] = new NotifView({
          model: notifModel
      });
    },
    render: function () {
      var self = this;
      self.$el.children().remove();
      _.each(self.model.models, function (userModel) {
        self.$el.append(self.subviews[userModel.cid].render().$el);
      });
      return self;
    }
  });

  PUApp.views.NotifsView = NotifsView;
}(window, $, _, Backbone, PUApp));