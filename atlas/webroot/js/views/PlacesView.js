define([
	'jquery',
	'underscore',
	'backbone',
	'views/MapView',
	'text!templates/places.html'
], function($, _, Backbone, mapView, placesTemplate) {
	console.log("PlacesView");
	var PlacesView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template(placesTemplate),

		initialize: function() {
			console.log("PlacesView.initialize");
		},

		render: function() {
			console.log("PlacesView.render");
			this.$el.html( this.template({}));
			mapView.render();
		}
	});

	return new PlacesView;
});