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

		render: function(page) {
			var p = 0;
			if (page != null) {
				p = parseInt(page);
			}
			console.log("PagerView.render");
			var pager = new Pager({
				total: 3,
				url: 'bars',
				limit: 10,
				current: p,
				prev: (p-1 < 0) ? null: p-1,
				next: (p+1 > 3) ? null: p+1,
				pages: new PageCollection([
					new Page({num:0, o:0 , active:(p==0) ? true : false }),
					new Page({num:1, o:10, active:(p==1) ? true : false }),
					new Page({num:2, o:20, active:(p==2) ? true : false })
				])
			});
			this.$el.html( this.template({pager:pager}));
		}
	});

	return PagerView;
});