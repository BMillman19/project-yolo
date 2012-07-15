(function (window, $, _, Backbone, PUApp) {
  var NotifView = Backbone.View.extend({
    tagName: 'div',
    className: 'notif box_shadow',
    template: _.template($('#notif-template').html() || ''),
    initialize: function () {
      this.model = this.options.model;
      this.model
        .on('change', _.bind(this.render, this));
    },
    events: {
      'click .pushpin': 'clickHandler'
    },
    clickHandler: function (e) {
      var pin = this.$el.find('.pushpin-img');
      pin.toggleClass('pushpin-active');
      if (pin.hasClass('pushpin-active')) {
        pin.attr('src', 'images/pushpin-active.png');
      } else {
        pin.attr('src', 'images/pushpin.png');
      }
    },
    render: function () {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    }
  });

  PUApp.views.NotifView = NotifView;
}(window, $, _, Backbone, PUApp));