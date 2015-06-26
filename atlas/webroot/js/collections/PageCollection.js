define([
	'jquery',
	'underscore',
	'backbone',
	'models/Page'
], function($, _, Backbone, Page) {
	var PageCollection = Backbone.Collection.extend({
		model: Page
	});
	return PageCollection;
});