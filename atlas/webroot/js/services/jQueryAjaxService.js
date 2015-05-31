define([
	'jquery',
	'underscore',
	'backbone',

	'config'
], function($, _, Backbone, settings) {
	console.log("jQueryAjaxService");
	var serv = {
		call: function (record, payload) {
			console.log("jQueryAjaxService.call");
			var url = settings.endpoint + record.uri;
			console.log("calling " + url);
			$.ajax({
				url: url,
				type: record.method,
				accept: 'application/json',
				contentType: 'application/json',
				dataType: 'json',
				processData: false,
				data: JSON.stringify(payload),
				headers: {
					"Header-Test": "This_is_a_test"
				},
				success: function (data, status, jqXHR) {
					console.log("success");
					console.log(data);
				},
				error: function (jqXHR, status, errorThrown) {
					console.log("error");
					console.log(errorThrown);	
				}
			});
		}
	};
	return serv;
});