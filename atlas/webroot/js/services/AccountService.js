define([
	'services/jQueryAjaxService',
	'services/jQueryAjaxRecords'
], function(jQueryAjaxService, jQueryAjaxRecords) {
	console.log("AccountService");
	return {

		login: function(payload) {
			jQueryAjaxService.call(jQueryAjaxRecords.login, payload);
		}
	};
});