define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',

	'views/MenuView',
	'services/AccountService',

	'text!templates/login.html',
	'config',

	'router'
], function($, _, Backbone, toastr, menuView, accountService, loginTemplate, settings){
	console.log('LoginView');
	LoginView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( loginTemplate),
		initialize: function() {
			console.log("LoginView.initialize");
		},

		render: function() {
			console.log("LoginView.render");
			this.$el.html( this.template({}));
		},

		events: {
			'click .request-login': 'doLogin'
		},

		doLogin: function (e) {
			console.log('LoginView.doLogin');
			var data = {
				username: $('input[name="username"]').val(),
				password: $('input[name="password"]').val()
			};
			accountService.login(data, this.onLoginSuccess);
		},

		onLoginSuccess: function(data) {
			console.log('LoginView.onLoginSuccess');

			console.log(router);

			//save the token
			settings.token = data.token;
			settings.tokenExpires = new Date(Date.parse(data.created));

			//render the menu
			window.router.navigate('', true);
		},

		onLoginFailure: function(error) {
			console.log('LoginView.onLoginFailure');
			toastr.error(error.message, "error");
		}
	});
	return new LoginView;
});