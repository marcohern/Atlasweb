require.config({
	shim: {
		bootstrap: {
			deps: ['jquery']
		}
	},
	paths: {
		jquery: '/js/jquery-2.1.4.min',
		underscore: '/js/underscore-min',
		backbone: '/js/backbone-min',
		bootstrap: '/bootstrap/js/bootstrap.min'
	}
});

require([
	'app',
	function (App) {
		console.log("main");
		App.initialize();
	}
]);