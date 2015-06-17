define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',
	'views/BaseView',

	'models/Place',
	'text!templates/places/form.html',
	'views/MapView',

	'router'
], function($, _, Backbone, toastr, BaseView, Place, placeFormTemplate, mapView){
	console.log("PlacesFormView");
	var UserFormView = BaseView.extend({
		el: $('#page_body'),
		template: _.template( placeFormTemplate),
		place: null,

		initialize: function() {
			this._initialize();
			console.log("PlacesFormView.initialize");
		},

		render: function(place_id) {
			console.log("PlacesFormView.render");
			var that = this;
			this.place = null;
			if (typeof place_id === "string") {
				this.place = new Place({id: place_id});
				this.place.fetch({
					success: function () {
						console.log("PlacesFormView.render.success");
						that.$el.html( that.template({place: that.place}));
						mapView.render();
						mapView.setCurrentMarker(that.place.get('lat'),that.place.get('lng'));
					},
					error: function()  {
						console.log("PlacesFormView.render.error");
						toastr.error("Unable to fetch place", "error");
					}
				});
			} else {
				this.place = new Place();
				this.$el.html( this.template({place: this.place}));
				mapView.render();
			}
		},

		events: {
			'click #place-save': 'requestSave',
			'click #place-save-cancel': 'gotoPlaces',
		},

		requestSave: function(e) {
			console.log("PlacesFormView.requestSave");

        	var data = this.getFormData( this.$el.find('form'));
        	console.log(data);
        	var that = this;
        	this.place.save(data, {
        		success: function(model, response) {
        			console.log("PlacesFormView.requestSave success");
					window.router.navigate('places', true);
        		},
        		error: function(model, response) {
        			console.log("PlacesFormView.requestSave error");
        			console.log(model);
        			console.log(response);
        			toastr.error(response.message, "Error Saving");
        		},
        		wait: true
        	});
        	return false;
		},

		gotoPlaces: function(e) {
			console.log("PlacesFormView.gotoPlaces");
			window.router.navigate('places', true);
		}
	});
	return new UserFormView;
});