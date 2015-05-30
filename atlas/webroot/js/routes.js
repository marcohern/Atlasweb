define([
	'backbone',
	'views/MenuView',
	'views/HomeView',
	'views/PlacesView',
	'views/EventsView',
	'views/RoutesView'
], function(Backbone, menuView, homeView, placesView, eventsView, routesView) {
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
			menuView.updateStatus('.goto-home');
		},

		gotoPlaces: function() {
			console.log("Router.gotoPlaces");
			placesView.render();
			menuView.updateStatus('.goto-places');
		},

		gotoEvents: function() {
			console.log("Router.gotoEvents");
			eventsView.render();
			menuView.updateStatus('.goto-events');
		},

		gotoRoutes: function() {
			console.log("Router.gotoRoutes");
			routesView.render();
			menuView.updateStatus('.goto-routes');
		}
	});

	var router = new Router;
	Backbone.history.start();

	return router;
});