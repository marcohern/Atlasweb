define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/places/index.html',
	'models/Place',
	'collections/PlaceCollection'
], function($, _, Backbone, placesTemplate, Place, PlaceCollection) {
	console.log("PlacesView");
	var PlacesView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template(placesTemplate),
		places: new PlaceCollection(),

		events: {
			'click #place-add': 'gotoPlaceAdd',
			'click .place-delete': 'deletePlace'
		},

		gotoPlaceAdd: function() {
			console.log("PlacesView.gotoPlaceAdd");
			window.router.navigate('places/add', true);
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

	return new PlacesView;
});