(function (window, $, _, Backbone, PUApp) {
  var NotifView = Backbone.View.extend({
    tagName: 'div',
    className: 'notif',
    template: _.template($('#notif-template').html() || ''),
    initialize: function () {
      this.model = this.options.model;
      this.model
        .on('change', _.bind(this.render, this));
    },
    events: {
      'click': 'clickHandler'
    },
    clickHandler: function (e) {

    },
    render: function () {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    }
  });

  PUApp.views.NotifView = NotifView;
}(window, $, _, Backbone, PUApp));