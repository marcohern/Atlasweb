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
		},

		render: function() {
			console.log("MenuView.render");
			this.$el.html( this.template({}));
		},

		events: {
			'click a' : 'updateStatus'
		},

		updateStatus: function(e) {
			console.log('MenuView.click event');
			this.$el.find('#navbar li').removeClass('active');
			$(e.target).parent().addClass('active');
			console.log(e.target);
		}
	});

	return new MenuView;
});