define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/places/index.html',
	'collections/PlaceCollection'
], function($, _, Backbone, placesTemplate, PlaceCollection) {
	console.log("PlacesView");
	var PlacesView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template(placesTemplate),
		places: new PlaceCollection(),

		events: {
			'click #place-add': 'gotoUserAdd',
			'click .place-delete': 'deleteUser'
		},

		gotoUserAdd: function() {
			console.log("PlacesView.gotoUserAdd");
			window.router.navigate('places/add', true);
		},

		initialize: function() {
			console.log("PlacesView.initialize");
		},

		render: function() {
			console.log("PlacesView.render");
			var that = this;
			this.places.fetch({
				success: function() {
					console.log("PlacesView.render.success");
					that.$el.html( that.template({places: that.places.models, error: false }));
					//mapView.render();
				},
				error: function(a,b,c) {
					console.log("PlacesView.render.error");
					console.log(a);
					console.log(b);
					that.$el.html( that.template({places: [], error: true }));
				}
			});
		}
	});

	return new PlacesView;
});