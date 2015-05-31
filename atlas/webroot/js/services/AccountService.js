define([
	'services/jQueryAjaxService',
	'services/jQueryAjaxRecords'
], function(jQueryAjaxService, jQueryAjaxRecords) {
	console.log("AccountService");
	return {

		login: function(payload, success, error) {
			jQueryAjaxService.call(jQueryAjaxRecords.login, payload, success, error);
		}
	};
});