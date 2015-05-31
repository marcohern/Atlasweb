define([], function () {
	console.log('config');
	window.appSettings = {
		endpoint: window.location.protocol + '//' + window.location.host
	};

	return window.appSettings;
});