define([
	'jquery',
	'underscore',
	'backbone',
	'Router',

	'text!templates/pager.html',
	'models/Pager',
	'collections/PageCollection',
	'models/Page'
], function($, _, Backbone, router, pagerTemplate, Pager, PageCollection, Page) {
	console.log("BarsView");
	var PagerView = Backbone.View.extend({
		el: $('.pager'),
		template: _.template(pagerTemplate),
		//pager: new Pager(),

		events: {
		},

		initialize: function() {
			console.log("PagerView.initialize");
		},

		render: function() {
			console.log("PagerView.render");
			var pager = new Pager({
				total: 3,
				url: 'nonexistent',
				pages: new PageCollection([
					new Page({num:1, l:10,o:0}),
					new Page({num:1, l:10,o:10}),
					new Page({num:1, l:10,o:20})
				])
			});
			this.$el.html( this.template({}));
		}
	});

	return PagerView;
});