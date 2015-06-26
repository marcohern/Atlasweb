define([
	'jquery',
	'underscore',
	'backbone',

	'text!templates/menu.html',
	'views/HomeView',
	'views/users/UsersView',
	'views/places/PlacesView',
	'views/EventsView',
	'views/RoutesView',
	'views/LoginView',
	'Router'
], function($, _, Backbone, menuTemplate, homeView, usersView, placesView, eventsView, routesView, loginView, router) {
	console.log("MenuView");
	
	var MenuView = Backbone.View.extend({
		el: $('#nav'),
		template: _.template( menuTemplate),
		displayed: false,

		initialize: function() {
			console.log("MenuView.initialize");
		},

		render: function() {
			console.log("MenuView.render");
			this.$el.html( this.template({}));
			this.displayed = true;
		},

		unrender: function() {
			this.$el.empty();
			this.displayed = false;
		},

		updateStatus: function(selector) {
			console.log('MenuView.updateStatus');
			if (typeof selector == 'string') {
				this.$el.find('#navbar li').removeClass('active');
				this.$el.find(selector).parent().addClass('active');
				console.log(selector);
			}
		},

		displayOrHideMenu: function(displayMenu, selector) {
			if (typeof displayMenu == 'boolean') {
				if (displayMenu) {
					if (!this.displayed) {
						this.render();
					}
				} else {
					if (this.displayed) {
						this.unrender();
					}
				}
			}
			if (this.displayed) {
				this.updateStatus(selector);
			}
		},

		goto: function(view, selector, displayMenu, data) {
			console.log("Router.goto");
			this.displayOrHideMenu(displayMenu, selector);
			view.render(data);
		},

		gotoHome: function() {
			this.goto(homeView, '.goto-home', true);
		},

		gotoUsers: function() {
			this.goto(usersView, '.goto-users', true);
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

		gotoLogin: function() {
			this.goto(loginView, undefined, false);
		}
	});

	router.views.menu = new MenuView;

	return router.views.menu;
});