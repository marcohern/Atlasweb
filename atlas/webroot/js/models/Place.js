define([
	'jquery',
	'underscore',
	'backbone'
], function($, _, Backbone) {
	var Place = Backbone.Model.extend({
		urlRoot: '/places',
		defaults: {
			name: '',
			description: '',
			lat: 0.0,
			lng: 0.0
		}
	});
	return Place;
});