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
		el: '.pager_control',
		limit: 10,
		template: _.template(pagerTemplate),
		//pager: new Pager(),

		events: {
		},

		initialize: function() {
			console.log("PagerView.initialize");
		},

		setLimit: function (limit) {
			this.limit = limit;
		},

		render: function(page, count) {
			var p = 0;
			if (page != null) {
				p = parseInt(page);
			}

			console.log("PagerView.render");
			var numPages = Math.ceil(count/this.limit);
			var lastPage = Math.floor(count/this.limit);
			var pages = new PageCollection;
			for (var i=0;i<numPages;i++) {
				pages.add({num:i, o:i*this.limit , active:(p==i) ? true : false });
			}
			var pager = new Pager({
				total: count,
				url: 'bars',
				limit: this.limit,
				current: p,
				prev: (p-1 < 0) ? null: p-1,
				next: (p+1 > lastPage) ? null: p+1,
				pages: pages
			});
			this.$el.html( this.template({pager:pager}));
		}
	});

	return PagerView;
});