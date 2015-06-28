define([
	'services/jQueryAjaxService',
	'services/jQueryAjaxRecords'
], function(jQueryAjaxService, jQueryAjaxRecords) {
	console.log("AccountService");
	return {

		login: function(payload, success, error) {
			jQueryAjaxService.call(jQueryAjaxRecords.login, payload, success, error);
		},

		bars: {
			count: function(success, error) {
				jQueryAjaxService.call(jQueryAjaxRecords.bars.count, null, success, error);
			}
		}
	};
});