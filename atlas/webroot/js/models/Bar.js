define([
	'jquery',
	'underscore',
	'backbone'
], function($, _, Backbone) {
	var Bar = Backbone.Model.extend({
		urlRoot: '/bars',
		defaults: {
			name: '',
			description: '',
			lat: 0.0,
			lng: 0.0
		}
	});
	return Bar;
});