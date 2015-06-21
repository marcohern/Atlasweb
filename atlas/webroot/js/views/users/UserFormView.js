
define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',
	'views/BaseView',

	'models/User',
	'text!templates/users/form.html',

	'Router'
], function($, _, Backbone, toastr, BaseView, User, userFormTemplate){
	console.log("UserFormView");
	var UserFormView = BaseView.extend({
		el: $('#page_body'),
		template: _.template( userFormTemplate),
		user: null,

		events: {
			'click #user-save': 'requestSave',
			'click #user-save-cancel': 'gotoUsers',
		},

		validations: {
			'username': {
				exp: /[a-zA-Z][a-zA-Z0-9._]*/,
				maxchar: 32
			}
		},

		initialize: function() {
			this._initialize();
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

		requestSave: function(e) {
			console.log("UserFormView.requestSave");
			var $form = this.$el.find('form');
        	var data = this.getFormData($form);
        	console.log(data);
        	var r = this.validate(data, $form);
        	return;
        	var that = this;
        	this.user.save(data, {
        		success: function(model, response) {
        			console.log("UserFormView.requestSave success");
					App.appRouter.navigate('users', true);
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
			App.appRouter.navigate('users', true);
		}
	});
	return new UserFormView;
});