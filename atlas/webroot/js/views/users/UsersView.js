define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/users/index.html',

	'models/User',
	'collections/UserCollection'
], function($, _, Backbone, usersTemplate, User, UserCollection) {
	console.log("UsersView");
	var UsersView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template(usersTemplate),
		users: new UserCollection(),

		initialize: function() {
			console.log("UsersView.initialize");

			//u1 = new User({id:3,username:"mack",email:"mach@mail.com",password:'123',fname:"Anthony",lname:"Macke",role:"ADMIN"});
			
		},

		render: function() {
			console.log("UsersView.render");
			var that = this;
			this.users.fetch({
				success: function() {
					console.log("UsersView.fetchSuccess");
					that.$el.html( that.template({users: that.users.models, error: false }));
				},
				error: function() {
					console.log("UsersView.fetchError");
					that.$el.html( that.template({users: [], error: true }));
				}
			});
		},

		events: {
			'click #user-add': 'gotoUserAdd'
		},

		gotoUserAdd: function(e) {
			console.log("UsersView.gotoUserAdd");
			window.router.navigate('users/add', true);
		}
	});

	return new UsersView;
});