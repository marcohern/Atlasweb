define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/users.html'
], function($, _, Backbone, usersTemplate) {
	console.log("UsersView");
	var UsersView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template(usersTemplate),

		initialize: function() {
			console.log("UsersView.initialize");
		},

		render: function() {
			console.log("UsersView.render");
			this.$el.html( this.template({}));
		}
	});

	return new UsersView;
});