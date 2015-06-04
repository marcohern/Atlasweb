
define([
	'jquery',
	'underscore',
	'backbone',

	'models/User',
	'text!templates/users/form.html'
], function($, _, Backbone, User, userFormTemplate){
	console.log("UserFormView");
	var UserFormView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( userFormTemplate),
		user: null,

		initialize: function() {
			console.log("UserFormView.initialize");
			this.user = new User();
		},

		render: function() {
			this.$el.html( this.template({}));
		},

		events: {
			'click #user-save': 'requestSave',
			'click #user-save-cancel': 'gotoUsers'
		},

		requestSave: function(e) {
			console.log("UserFormView.requestSave");

        	var data = JSON.stringify( this.getFormData( this.$el.find('form') ) );
        	this.user.save(data);
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