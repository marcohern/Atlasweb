define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/home.html'
], function($, _, Backbone, homeTemplate) {
	console.log("HomeView");
	var HomeView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( homeTemplate),

		initialize: function() {
			console.log("HomeView.initialize");
		},

		render: function() {
			console.log("HomeView.render");
			this.$el.html( this.template({}));
		}
	});

	return new HomeView;
});