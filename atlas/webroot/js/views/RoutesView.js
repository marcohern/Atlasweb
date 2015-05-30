define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/routes.html'
], function($, _, Backbone, routesTemplate) {
	console.log("RoutesView");
	var RoutesView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( routesTemplate),

		initialize: function() {
			console.log("RoutesView.initialize");
		},

		render: function() {
			console.log("RoutesView.render");
			this.$el.html( this.template({}));
		}
	});

	return new RoutesView;
});