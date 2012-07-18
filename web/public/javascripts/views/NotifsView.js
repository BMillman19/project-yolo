(function (window, $, _, Backbone, PUApp) {
  var NotifsView = Backbone.View.extend({
    el: '#notifs',
    template: _.template($('#notif-template').html() || ''),
    initialize: function () {
      this.model = this.options.model;
    },
    events: {
      'click .notif-tag': 'filterByTag',
      'click .pushpin': 'togglePushpin'
    },
    togglePushpin: function (e) {
      var pin = $(e.currentTarget).find('.pushpin-img');
      if (pin.toggleClass('pushpin-active').hasClass('pushpin-active')) {
        pin.attr('src', 'images/pushpin-active.png');
      } else {
        pin.attr('src', 'images/pushpin.png');
      }
    },
    filterByTag: function (e) {
      var tagName = $(e.target).html();
      this.render(this.model.filterByTag(tagName));
    },
    resetSelection: function () {
      this.render();
    },
    search: function (query) {
      this.render(this.model.search(query));
    },
    render: function (models) {
      var templateCtx = (models && _.invoke(models, 'toJSON')) || this.model.toJSON();
      this.$el.html(this.template(templateCtx));
      return this;
    }
  });

  PUApp.views.NotifsView = NotifsView;
}(window, $, _, Backbone, PUApp));