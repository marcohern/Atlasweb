define([
	'jquery',
	'underscore',
	'backbone'
], function($, _, Backbone) {
	console.log("MapView");
	var MapView = Backbone.View.extend({
		mapId: 'map_places',
		el: '#map_places',
		map: null,
		loaded: false,
		mapOptions: null,

		initialize: function() {
			console.log("MapView.initialize");
			//google.maps.event.addDomListener(window, 'load', this.onload);
		},

		loadMap: function() {

		},

		onload: function() {
			console.log("MapView.onload");
			var mapOptions = {
				center: { lat: -34.397, lng: 150.644},
				zoom: 8
			};
	        this.map = new google.maps.Map(document.getElementById('map'), mapOptions);
	        this.loaded = true;
	        this.mapOptions = mapOptions;
		},

		render: function() {
			console.log("MapView.render");
			this.onload();
		}
	});

	return new MapView;
});