define([], function () {
	console.log('config');
	window.appSettings = {
		endpoint: window.location.protocol + '//' + window.location.host,
		token: null,
		tokenExpires: null
	};

	if (typeof window.localStorage !== 'undefined') {
		window.appSettings.token = localStorage.getItem('token');
		window.appSettings.tokenExpires = localStorage.getItem('tokenExpires');
	}

	return window.appSettings;
});