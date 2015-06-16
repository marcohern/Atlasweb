define([
	'jquery',
	'underscore',
	'backbone',
	'models/Place'
], function($, _, Backbone, Place) {
	var PlaceCollection = Backbone.Collection.extend({
		model: Place,
		url: '/places'
	});
	return PlaceCollection;
});