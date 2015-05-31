define([
	'backbone',
	'views/MenuView',
	'views/HomeView',
	'views/PlacesView',
	'views/EventsView',
	'views/RoutesView',
	'services/AccountService'
], function(Backbone, menuView, homeView, placesView, eventsView, routesView, accountService) {
	console.log("Router");
	var Router = Backbone.Router.extend({
		routes: {
			'' : 'gotoHome',
			'places' : 'gotoPlaces',
			'events' : 'gotoEvents',
			'routes' : 'gotoRoutes'
		},

		goto: function(view, selector) {
			console.log("Router.goto");
			view.render();
			menuView.updateStatus(selector);
		},

		gotoHome: function() {
			this.goto(homeView, '.goto-home');
		},

		gotoPlaces: function() {
			this.goto(placesView, '.goto-places');
		},

		gotoEvents: function() {
			this.goto(eventsView, '.goto-events');
		},

		gotoRoutes: function() {
			this.goto(routesView, '.goto-routes');
			accountService.login({username:"marcohern",password:"password"});
		}
	});

	var router = new Router;
	Backbone.history.start();

	return router;
});