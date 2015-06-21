define([
	'jquery',
	'underscore',
	'backbone',
	'toastr'
], function($, _, Backbone, toastr){

	console.log('BaseView');
	var BaseView = Backbone.View.extend({
		_initialize: function() {
			console.log('BaseView.initialize');
		},
		validations: {

		},

		getFormData: function($form) { 
			var unindexed_array = $form.serializeArray();
			var indexed_array = {};

			$.map(unindexed_array, function(n, i){
				indexed_array[n['name']] = n['value'];
			});
			return indexed_array;
    	},

    	validate: function(formData, $form) {
    		console.log("BaseView.validate");
    		var result = true;
    		var r;
    		var value;
    		var validation;
    		var i;
    		for (var i in this.validations) {
    			if (typeof formData[i] === 'string') {
    				validation = this.validations[i];
    				value = formData[i];
    				r = this.validateField(validation, value);
    				if (!r) this.hilightField(i, $form);
    				result = result && r;
    			}
    		}
    		return result;
    	},

    	validateField: function(validation, value) {
    		console.log("BaseView.validateField");
    		if (typeof validation.maxchar === 'number') {
    			if (value.length > validation.maxchar) {
    		console.log("BaseView.validateField.axchar failed");
    				return false;
    			}
    		}
    		if (validation.exp instanceof RegExp) {
    			console.log("BaseView.validateField.testing regex");
    			return validation.exp.test(value);
    		}
    		return false;
    	},
    	hilightField: function(field, $form) {
    		console.log("BaseView.hilightField");
    		var sel = 'input[name="' + field + '"],select[name="' + field + '"],textarea[name="' + field + '"]';
    		console.log(sel);
    		toastr.error("Error in " + field);
    		$($form).find(sel).css({backgroundColor:'#ffdddd'});
    	},
    	unhilightAllFields: function($form) {
    		var sel = 'input,select,textarea';
    		$($form).find(sel).css({backgroundColor:'white'});
    	}
	});
	return BaseView;
});