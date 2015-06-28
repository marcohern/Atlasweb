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
		template: _.template(pagerTemplate),
		//pager: new Pager(),

		events: {
		},

		initialize: function() {
			console.log("PagerView.initialize");
		},

		render: function(page, count) {
			var p = 0;
			var limit = 10;
			if (page != null) {
				p = parseInt(page);
			}

			console.log("PagerView.render");
			var numPages = Math.ceil(count/limit);
			var lastPage = Math.floor(count/limit);
			var pages = new PageCollection;
			for (var i=0;i<numPages;i++) {
				pages.add({num:i, o:i*limit , active:(p==i) ? true : false });
			}
			var pager = new Pager({
				total: count,
				url: 'bars',
				limit: 10,
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