define([
	'backbone',
	'views/HomeView',
	'views/PlacesView'
], function(Backbone, homeView, placesView) {
	console.log("Router");
	var Router = Backbone.Router.extend({
		routes: {
			'' : 'gotoHome',
			'places' : 'gotoPlaces',
			'events' : 'gotoEvents',
			'routes' : 'gotoRoutes'
		},

		gotoHome: function() {
			console.log("Router.gotoHome");
			homeView.render();
		},

		gotoPlaces: function() {
			console.log("Router.gotoPlaces");
			placesView.render();
		},

		gotoEvents: function() {
			console.log("Router.gotoEvents");
		},

		gotoRoutes: function() {
			console.log("Router.gotoRoutes");
		}
	});

	Backbone.history.start();
	var router = new Router;
	return router;
});