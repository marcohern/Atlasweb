define([
	'jquery',
	'underscore',
	'backbone'
], function($, _, Backbone) {
	var Page = Backbone.Model.extend({
		defaults: {
			num: 0,
			url: '',
			l  : 10,
			o  : 0
		}
	});
	return Page;
});