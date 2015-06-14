
define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',

	'models/User',
	'text!templates/users/form.html',

	'router'
], function($, _, Backbone, toastr, User, userFormTemplate){
	console.log("UserFormView");
	var UserFormView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( userFormTemplate),
		user: null,

		initialize: function() {
			console.log("UserFormView.initialize");
		},

		render: function(user_id) {
			console.log("UserFormView.render");
			var that = this;
			this.user = null;
			if (typeof user_id === "string") {
				this.user = new User({id: user_id});
				this.user.fetch({
					success: function () {
						console.log("UserFormView.render.success");
						that.$el.html( that.template({user: that.user}));
					},
					error: function()  {
						console.log("UserFormView.render.error");
						toastr.error("Unable to fetch user", "error");
					}
				});
			} else {
				this.user = new User();
				this.$el.html( this.template({user: this.user}));
			}
		},

		events: {
			'click #user-save': 'requestSave',
			'click #user-save-cancel': 'gotoUsers',
		},

		requestSave: function(e) {
			console.log("UserFormView.requestSave");

        	var data = this.getFormData( this.$el.find('form'));
        	console.log(data);
        	var that = this;
        	this.user.save(data, {
        		success: function(model, response) {
        			console.log("UserFormView.requestSave success");
					window.router.navigate('users', true);
        		},
        		error: function(model, response) {
        			console.log("UserFormView.requestSave error");
        			console.log(model);
        			console.log(response);
        			toastr.error(response.message, "Error Saving");
        		},
        		wait: true
        	});
        	return false;
		},

		gotoUsers: function(e) {
			console.log("UserFormView.gotoUsers");
			window.router.navigate('users', true);
		},

		getFormData: function(form) { 
			var unindexed_array = form.serializeArray();
			var indexed_array = {};

			$.map(unindexed_array, function(n, i){
				indexed_array[n['name']] = n['value'];
			});
			return indexed_array;
    },
	});
	return new UserFormView;
});