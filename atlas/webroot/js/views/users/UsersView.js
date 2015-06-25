define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',
	'Router',
	'text!templates/users/index.html',

	'models/User',
	'collections/UserCollection',

	'views/users/UserFormView'
], function($, _, Backbone, toastr, router, usersTemplate, User, UserCollection, userFormView) {
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
			'click .user-delete': 'deleteUser'
		},

		gotoAdd: function() {
			console.log("UsersView.gotoAdd");
			userFormView.render();
		},

		gotoEdit: function(id) {
			console.log("UsersView.gotoAdd");
			userFormView.render(id);
		},

		deleteUser: function(e) {
			console.log("UsersView.deleteUser");
			var user_id = $(e.currentTarget).data('user-id');
			console.log(user_id);
			var user = new User({id:user_id});
			user.destroy({
				success: function(model, response) {
					console.log("UsersView.deleteUser.success");
					$(e.currentTarget).parents('tr').remove();
				},
				error: function(model, response) {
					console.log("UsersView.deleteUser.error");
        			toastr.error(response.message, "Error Saving");
				}
			});
		}
	});
	router.views.users = new UsersView;
	return router.views.users;
});