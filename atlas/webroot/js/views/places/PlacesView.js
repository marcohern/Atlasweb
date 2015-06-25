define([
	'jquery',
	'underscore',
	'backbone',
	'Router',

	'text!templates/places/index.html',
	'models/Place',
	'collections/PlaceCollection',
	'views/places/PlacesFormView'
], function($, _, Backbone, router, placesTemplate, Place, PlaceCollection, placesFormView) {
	console.log("PlacesView");
	var PlacesView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template(placesTemplate),
		places: new PlaceCollection(),

		events: {
			'click .place-delete': 'deletePlace'
		},

		gotoAdd: function() {
			console.log("PlacesView.gotoPlaceAdd");
			placesFormView.render();
		},

		deletePlace: function(e) {
			console.log("UsersView.deleteUser");
			var place_id = $(e.currentTarget).data('place-id');
			console.log(place_id);
			var place = new Place({id:place_id});
			place.destroy({
				success: function(model, response) {
					console.log("UsersView.deleteUser.success");
					$(e.currentTarget).parents('tr').remove();
				},
				error: function(model, response) {
					console.log("UsersView.deleteUser.error");
        			toastr.error(response.message, "Error Saving");
				}
			});
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

	router.views.places = new PlacesView;
	return router.views.places;
});