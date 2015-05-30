define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/events.html'
], function($, _, Backbone, eventsTemplate) {
	console.log("EventsView");
	var EventsView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( eventsTemplate),

		initialize: function() {
			console.log("EventsView.initialize");
		},

		render: function() {
			console.log("EventsView.render");
			this.$el.html( this.template({}));
		}
	});

	return new EventsView;
});