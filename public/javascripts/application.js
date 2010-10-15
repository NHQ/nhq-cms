
var app = {

	setupCreditForms: function() {
		// Make credit list sortable
	  $('#credits ul').sortable({handle:".handle"}).disableSelection();

	  // Wire up the add credit button
	  $('#add').click(function(e) {
	    e.preventDefault();
	    var creditItem = $('#credits ul li:first').clone();
	    creditItem.find('form')[0].reset();
	    $('#credits ul').append(creditItem);
	    creditItem.find("input[type='text']:first").focus();
	  });

	  // Create two extra credit fields
	  $('#add').click().click();
	},
	

	setupAjaxCallbacks: function() {
		$('body').ajaxStart(function() {
			$('#ajax-status').show().text("Loading...");
		});
		$('body').ajaxStop(function() {
			$('#ajax-status').fadeOut();
		});
		$('body').ajaxError(function (event, xhr, ajaxOptions, thrownError) {
			if (xhr.status === 401) {
				if ($('#login').is(":hidden")) {
					app.showLoginForm();
				}
				alert("Sorry, " + xhr.responseText.toLowerCase());
				$("#login input[type='text']:first").focus();
			}
			console.log("XHR Response: " + JSON.stringify(xhr));
		});	
	}

};

jQuery(function() {

	app.setupAjaxCallbacks();

	app.setupCreditForms();

  // Focus on the first text field
  $("input[type='text']:first").focus();

});