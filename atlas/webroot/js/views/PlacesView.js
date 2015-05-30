define([
	'jquery',
	'underscore',
	'backbone',
	'text!templates/places.html'
], function($, _, Backbone, placesTemplate) {
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
		}
	});

	return new PlacesView;
});