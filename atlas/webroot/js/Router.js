define([
	'backbone',
	'services/AccountService',
	'config'
], function(Backbone, accountService, settings) {
	console.log("Router");
	window.App = (window.App || {});

	var Router = Backbone.Router.extend({
		routes: {
			//Acceible from menu
			'' : 'gotoHome',
			'users'  : 'gotoUsers',
			'places' : 'gotoPlaces',
			'events' : 'gotoEvents',
			'routes' : 'gotoRoutes',
			'login'  : 'gotoLogin',
			'logout' : 'gotoLogout',

			//others accesible from within pages
			'users/add'  : 'gotoUserAdd',
			'users/edit/:id'  : 'gotoUserEdit',
			'places/add' : 'gotoPlacesAdd',
			'places/edit/:id' : 'gotoPlacesEdit',
		},
		views: {},

		initialize: function() {
			console.log("Router.initialize");
		},

		gotoLogin: function() {
			this.views.menu.gotoLogin();
		},

		gotoLogout: function() {
			settings.token = null;
			settings.tokenExpires = null;

			this.navigate('login', true);
		},

		gotoHome: function() {
			this.views.menu.gotoHome();
		},

		gotoUsers: function() {
			this.views.menu.gotoUsers();
		},

		gotoPlaces: function() {
			this.views.menu.gotoPlaces();
		},

		gotoEvents: function() {
			this.views.menu.gotoEvents();
		},

		gotoRoutes: function() {
			this.views.menu.gotoRoutes();
		},

		gotoUserAdd: function() {
			this.views.users.gotoAdd();
		},

		gotoUserEdit: function(id) {
			this.views.users.gotoEdit(id);
		},

		gotoPlacesAdd: function() {
			this.views.places.gotoAdd();
		},

		gotoPlacesEdit: function(id) {
			this.views.places.gotoEdit(id);
		}
	});

	return new Router;
});