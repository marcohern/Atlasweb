define([
	'jquery',
	'underscore',
	'backbone'
], function($, _, Backbone) {
	var User = Backbone.Model.extend({
		urlRoot: '/users',
		defaults: {
			username: '',
			email: '',
			password: '',
			salt: '',
			fname: '',
			lname: '',
			role: '',
			created: null,
			updated: null
		}
	});
	return User;
});