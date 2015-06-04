define([
	'backbone',
	'views/MenuView',
	'views/HomeView',
	'views/users/UsersView',
	'views/users/UserFormView',
	'views/PlacesView',
	'views/EventsView',
	'views/RoutesView',
	'views/LoginView',
	'services/AccountService',
	'config'
], function(Backbone,
	menuView, homeView,
	usersView, userFormView,
	placesView, eventsView, routesView, loginView,
	accountService, settings) {
	console.log("Router");
	var Router = Backbone.Router.extend({
		routes: {
			'' : 'gotoHome',
			'users'  : 'gotoUsers',
			'users/add'  : 'gotoUserAdd',
			'places' : 'gotoPlaces',
			'events' : 'gotoEvents',
			'routes' : 'gotoRoutes',
			'login'  : 'gotoLogin',
			'logout' : 'gotoLogout'
		},

		displayOrHideMenu: function(displayMenu, selector) {
			if (typeof displayMenu == 'boolean') {
				if (displayMenu) {
					if (!menuView.displayed) {
						menuView.render();
					}
				} else {
					if (menuView.displayed) {
						menuView.unrender();
					}
				}
			}
			if (menuView.displayed) {
				menuView.updateStatus(selector);
			}
		},

		goto: function(view, selector, displayMenu) {
			console.log("Router.goto");
			this.displayOrHideMenu(displayMenu, selector);
			view.render();
		},

		gotoLogin: function() {
			this.goto(loginView, undefined, false);
		},

		gotoHome: function() {
			this.goto(homeView, '.goto-home', true);
		},

		gotoUsers: function() {
			this.goto(usersView, '.goto-users', true);
		},

		gotoUserAdd: function() {
			this.goto(userFormView, '.goto-users', true);
		},

		gotoPlaces: function() {
			this.goto(placesView, '.goto-places', true);
		},

		gotoEvents: function() {
			this.goto(eventsView, '.goto-events', true);
		},

		gotoRoutes: function() {
			this.goto(routesView, '.goto-routes', true);
		},

		gotoLogout: function() {
			settings.token = null;
			settings.tokenExpires = null;

			this.navigate('login', true);
		}
	});

	window.router = new Router;
	Backbone.history.start();

	return window.router;
});