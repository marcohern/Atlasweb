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
		displayed: false,

		initialize: function() {
			console.log("MenuView.initialize");
		},

		render: function() {
			console.log("MenuView.render");
			this.$el.html( this.template({}));
			this.displayed = true;
		},

		unrender: function() {
			this.$el.empty();
			this.displayed = false;
		},

		updateStatus: function(selector) {
			console.log('MenuView.updateStatus');
			if (typeof selector == 'string') {
				this.$el.find('#navbar li').removeClass('active');
				this.$el.find(selector).parent().addClass('active');
				console.log(selector);
			}
		}
	});

	return new MenuView;
});