var geocoder;
var map;

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
	},

	gmapInitialize: function() {
	  geocoder = new google.maps.Geocoder();
	  var latlng = new google.maps.LatLng(-34.397, 150.644);
	  var myOptions = {
	    zoom: 12,
	    center: latlng,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	  }
	  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
	},

	codeAddress: function() {
	  var address = document.getElementById("address").value;
	  geocoder.geocode( { 'address': address}, function(results, status) {
	    if (status == google.maps.GeocoderStatus.OK) {
	      map.setCenter(results[0].geometry.location);
	      var marker = new google.maps.Marker({
	          map: map, 
	          position: results[0].geometry.location
	      });
	    } else {
	      alert("Geocode was not successful for the following reason: " + status);
	    }
	  });
	}

};

jQuery(function() {

	app.setupAjaxCallbacks();

  // Focus on the first text field
  $("input[type='text']:first").focus();

	app.gmapInitialize();
	
	app.codeAddress();

});