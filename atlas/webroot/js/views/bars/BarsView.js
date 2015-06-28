define([
	'jquery',
	'underscore',
	'backbone',
	'Router',

	'text!templates/bars/index.html',
	'models/Bar',
	'collections/BarCollection',
	'views/PagerView',
	'services/AccountService'
	//'views/bars/BarFormView'
], function($, _, Backbone, router, barsTemplate, Bar, BarCollection, PagerView, accountService) {
	console.log("BarsView");
	var BarsView = Backbone.View.extend({
		el: '#page_body',
		template: _.template(barsTemplate),
		bars: new BarCollection(),

		events: {
			'click .place-delete': 'deletePlace'
		},

		gotoAdd: function() {
			console.log("BarsView.gotoAdd");
			placesFormView.render();
		},

		deleteBar: function(e) {
			console.log("BarsView.deleteBar");
			var bar_id = $(e.currentTarget).data('bar-id');
			console.log(bar_id);
			var bar = new Bar({id:bar_id});
			place.destroy({
				success: function(model, response) {
					console.log("BarsView.deleteBar.success");
					$(e.currentTarget).parents('tr').remove();
				},
				error: function(model, response) {
					console.log("UsersView.deleteBar.error");
        			toastr.error(response.message, "Error Saving");
				}
			});
		},

		initialize: function() {
			console.log("BarsView.initialize");
		},

		render: function(data) {
			console.log("BarsView.render");
			var that = this;
			var page = 0;
			if (data) {
				if (data.page) {
					page = data.page;
				}
			}

			accountService.bars.count(
				function(count_data) {
					console.log("BarsView.render.count.success");
					that.bars.fetch({
						data:{l:10,o:10*page},
						success: function() {
							console.log("BarsView.render.success");
							that.$el.html( that.template({bars: that.bars.models, error: false }));
							var pagerView = new PagerView;
							pagerView.render(page, count_data[0].count);
							//mapView.render();
						},
						error: function(a,b,c) {
							console.log("BarsView.render.error");
							console.log(a);
							console.log(b);
							that.$el.html( that.template({bars: [], error: true }));
						}
					});
				},
				function() {
					console.log("BarsView.render.count.error");
				}
			);
		}
	});

	router.views.bars = new BarsView;
	return router.views.bars;
});