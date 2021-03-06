define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',
	'config',
	'Router',

	'views/MenuView',
	'views/HomeView'
], function($, _, Backbone, toastr, settings, router,

	menuView, homeView)
{
	console.log("app");
	window.App = (window.App || {});
	
	toastr.options = {
		"closeButton": false,
		"debug": false,
		"newestOnTop": false,
		"progressBar": false,
		"positionClass": "toast-top-right",
		"preventDuplicates": false,
		"onclick": null,
		"showDuration": "300",
		"hideDuration": "1000",
		"timeOut": "5000",
		"extendedTimeOut": "1000",
		"showEasing": "swing",
		"hideEasing": "linear",
		"showMethod": "fadeIn",
		"hideMethod": "fadeOut"
	};

	var onBeforeSend = function(xhr) {
		console.log("onBeforeSend");
		$('#loading').show();
		if (typeof settings.token === 'string') {
			console.log("TOKEN: " + settings.token);
			xhr.setRequestHeader('Token',settings.token);
		} else {
			console.log("No token");
		}
	};

	var onComplete = function() {
		console.log("onComplete");
		$('#loading').hide();
	};

	var sync = Backbone.sync;
	Backbone.sync = function(method, model, options) {
		console.log("Backbone.sync");
		options.beforeSend = function(xhr) {
			console.log("Backbone.sync.beforeSend");
			onBeforeSend(xhr);
		};
		options.complete = function(xhr) {
			onComplete();
		};
		sync(method, model, options);
	};

	$(document).ajaxSend = function(event, jqxhr, options) {
		console.log("document.ajaxSend");
		onBeforeSend(jqxhr);
	};

	$(document).ajaxComplete = function(event, jqxhr, options) {
		console.log("document.ajaxComplete");
		onComplete();
	};

	Backbone.history.start();

	return {};
});