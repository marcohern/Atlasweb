define([
	'jquery',
	'underscore',
	'backbone',
	'toastr',

	'config'
], function($, _, Backbone, toastr, settings) {
	console.log("jQueryAjaxService");
	var serv = {
		initialize: function () {
			console.log("jQueryAjaxService.initialize");
		},
		call: function (record, payload, success, error) {
			console.log("jQueryAjaxService.call");
			var url = settings.endpoint + record.uri;
			var payload_str = (payload === null) ? null : JSON.stringify(payload);
			console.log("calling " + url);
			$.ajax({
				url: url,
				type: record.method,
				accept: 'application/json',
				contentType: 'application/json',
				dataType: 'json',
				processData: false,
				data: payload_str,
				success: function (data, status, jqXHR) {
					console.log("success");
					console.log(data);
					if (typeof success == 'function')
						success(data);
				},
				error: function (jqXHR, status, errorThrown) {
					console.log("error");
					var errorData = JSON.parse(jqXHR.responseText);
					console.log(jqXHR.getResponseHeader('Content-type'));
					toastr.error(errorData.message, errorThrown);
					if (typeof error == 'function') {
						error(errorData);
					}
				}
			});
		}
	};
	serv.initialize();
	return serv;
});