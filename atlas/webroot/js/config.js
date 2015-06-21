define([], function () {
	console.log('config');
	window.App = (window.App || {});
	window.App.Settings = (window.App.Settings || {});
	
	window.App.Settings = {
		endpoint: window.location.protocol + '//' + window.location.host,
		token: null,
		tokenExpires: null
	};

	if (typeof window.localStorage !== 'undefined') {
		window.App.Settings.token = localStorage.getItem('token');
		window.App.Settings.tokenExpires = localStorage.getItem('tokenExpires');
	}

	return window.App.Settings;
});