define([
	'jquery',
	'underscore',
	'backbone',

	'text!templates/menu.html'
], function($, _, Backbone, menuTemplate) {
	console.log("MenuView");
	
	var MenuView = Backbone.View.extend({
		el: $('#nav'),
		template: _.template( menuTemplate),

		initialize: function() {
			console.log("MenuView.initialize");
			this.render();
		},

		render: function() {
			console.log("MenuView.render");
			this.$el.html( this.template({}));
		},

		updateStatus: function(selector) {
			console.log('MenuView.click event');
			this.$el.find('#navbar li').removeClass('active');
			this.$el.find(selector).parent().addClass('active');
			console.log(selector);
		},


	});

	return new MenuView;
});