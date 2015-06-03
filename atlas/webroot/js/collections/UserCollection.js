define([
	'jquery',
	'underscore',
	'backbone',
	'models/User'
], function($, _, Backbone, User) {
	var UserCollection = Backbone.Collection.extend({
		model: User,
		url: '/users'
	});
	return UserCollection;
});