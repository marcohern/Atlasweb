define([
	'jquery',
	'underscore',
	'backbone',
	'models/Bar'
], function($, _, Backbone, Bar) {
	var BarCollection = Backbone.Collection.extend({
		model: Bar,
		url: '/bars'
	});
	return BarCollection;
});