define([], function() {
	console.log("jQueryAjaxRecords");
	return {
		login: {
			method: 'POST',
			uri: '/account/login'
		},
		bars: {
			count: {
				method: 'GET',
				uri:'/bars?count'
			}
		}
	};
});