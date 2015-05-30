define([
	'backbone',
	'views/HomeView',
	'views/PlacesView',
	'views/EventsView'
], function(Backbone, homeView, placesView, eventsView) {
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
			eventsView,render();
		},

		gotoRoutes: function() {
			console.log("Router.gotoRoutes");
		}
	});

	var router = new Router;
	Backbone.history.start();

	return router;
});