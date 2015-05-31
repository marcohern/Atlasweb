define([], function () {
	console.log('config');
	window.appSettings = {
		endpoint: window.location.protocol + '//' + window.location.host,
		token: null,
		tokenExpires: null
	};

	return window.appSettings;
});