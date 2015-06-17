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
		mapOptions: {
			center: { lat: 11.234138452544283, lng: -74.2005443572998},
			zoom: 13
		},
		cursorMarker: null,

		initialize: function() {
			console.log("MapView.initialize");
			//google.maps.event.addDomListener(window, 'load', this.onload);
		},

		loadMap: function() {
			console.log("MapView.onload");
	        this.map = new google.maps.Map(document.getElementById('map'), this.mapOptions);
	        this.loaded = true;

			var that = this;
	        google.maps.event.addDomListener(this.map, 'click', function(e) { that.onClickMap(e); });
		},

		getCursorMarker: function() {
			if (this.cursorMarker == null) {
				this.cursorMarker = new google.maps.Marker({
					map: this.map,
					title: 'Current Position'
				});
			}
			return this.cursorMarker;
		},

		_onClickMap: function(source, e) {
			source.onClickMap.call(source, e);
		},

		onClickMap: function(e) {
			console.log("MapView.onClickMap");
			$('input[name="lat"]').val(e.latLng.A);
			$('input[name="lng"]').val(e.latLng.F);

			var marker = this.getCursorMarker();
			marker.setPosition(e.latLng);
		},

		setCurrentMarker: function(lat, lng) {
			console.log("MapView.setCurrentMarker");
			var latLng = new google.maps.LatLng(lat,lng);
			var marker = this.getCursorMarker();
			marker.setPosition(latLng);
		},

		render: function() {
			console.log("MapView.render");
			this.cursorMarker = null;
			this.loadMap();
		}
	});

	return new MapView;
});