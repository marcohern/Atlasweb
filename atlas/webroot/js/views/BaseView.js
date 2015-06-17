define([
	'jquery',
	'underscore',
	'backbone'
], function($, _, Backbone){

	console.log('BaseView');
	var BaseView = Backbone.View.extend({
		_initialize: function() {
			console.log('BaseView.initialize');
		},

		getFormData: function(form) { 
			var unindexed_array = form.serializeArray();
			var indexed_array = {};

			$.map(unindexed_array, function(n, i){
				indexed_array[n['name']] = n['value'];
			});
			return indexed_array;
    	}
	});
	return BaseView;
});