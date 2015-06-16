define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',

	'models/Place',
	'text!templates/places/form.html',
	'views/MapView',

	'router'
], function($, _, Backbone, toastr, Place, placeFormTemplate, mapView){
	console.log("PlacesFormView");
	var UserFormView = Backbone.View.extend({
		el: $('#page_body'),
		template: _.template( placeFormTemplate),
		place: null,

		initialize: function() {
			console.log("PlacesFormView.initialize");
		},

		render: function(place_id) {
			console.log("PlacesFormView.render");
			var that = this;
			this.place = null;
			if (typeof place_id === "string") {
				this.place = new User({id: place_id});
				this.place.fetch({
					success: function () {
						console.log("UserFormView.render.success");
						that.$el.html( that.template({place: that.place}));
						mapView.render();
					},
					error: function()  {
						console.log("UserFormView.render.error");
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
			'click #user-save': 'requestSave',
			'click #user-save-cancel': 'gotoUsers',
		},

		requestSave: function(e) {
			console.log("UserFormView.requestSave");

        	var data = this.getFormData( this.$el.find('form'));
        	console.log(data);
        	var that = this;
        	this.user.save(data, {
        		success: function(model, response) {
        			console.log("UserFormView.requestSave success");
					window.router.navigate('users', true);
        		},
        		error: function(model, response) {
        			console.log("UserFormView.requestSave error");
        			console.log(model);
        			console.log(response);
        			toastr.error(response.message, "Error Saving");
        		},
        		wait: true
        	});
        	return false;
		},

		gotoUsers: function(e) {
			console.log("UserFormView.gotoUsers");
			window.router.navigate('users', true);
		},

		getFormData: function(form) { 
			var unindexed_array = form.serializeArray();
			var indexed_array = {};

			$.map(unindexed_array, function(n, i){
				indexed_array[n['name']] = n['value'];
			});
			return indexed_array;
    },
	});
	return new UserFormView;
});