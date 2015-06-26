define([
	'jquery',
	'underscore',
	'backbone',
	'collections/PageCollection'
], function($, _, Backbone, PageCollection) {
	var Pager = Backbone.Model.extend({
		defaults: {
			total: 0,
			url: '',
			pages: new PageCollection
		}
	});
	return Pager;
});