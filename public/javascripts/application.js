var app = {
	
	setupAjaxCallbacks: function() {
		$('body').ajaxStart(function() {
			$('#ajax-status').show().text("Loading...");
		});
		$('body').ajaxStop(function() {
			$('#ajax-status').fadeOut();
		});
		$('body').ajaxError(function (event, xhr, ajaxOptions, thrownError) {
			console.log("XHR Response: " + JSON.stringify(xhr));
		});	
	},

	codeAddress: function() {
		
	  geocoder = new google.maps.Geocoder();
	  var latlng = new google.maps.LatLng(-34.397, 150.644);
	  var myOptions = {
	    zoom: 12,
	    center: latlng,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	  }
	  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
		
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
	},
	
	setupShowdates: function() {

		var options = { usa : true, isoTime : false, defaultHour : 20};

    // initialize date form
		$("#showdate_start_date, #showdate_start_time," +
		  "#showdate_end_date,   #showdate_end_time")
		    .calendricalDateTimeRange(options);

    // show form
		$("#add_showdate").click(function() {
		  $("#new_showdate").toggle("slow");
		});

		// auto-fill end_date with start_date value
		$("#showdate_start_date").blur(function() {
		  $("#showdate_end_date").val($("#showdate_start_date").val());
		});
	},
	
	
	setupCredits: function() {
		
    // show form
		$("#add_credit").click(function() {
			$("#credit_title").empty();
		  $("#new_credit").toggle("slow", function() {
				$("#credit_title").focus();
			});
		});
		
		// // Make credit list sortable
		// 	  $('#credits ul').sortable({handle:".handle"}).disableSelection();
		// 
		// 	  // Wire up the add credit button
		// 	  $('#add').click(function(e) {
		// 	    e.preventDefault();
		// 	    var creditItem = $('#credits ul li:first').clone();
		// 	    creditItem.find('form')[0].reset();
		// 	    $('#credits ul').append(creditItem);
		// 	    creditItem.find("input[type='text']:first").focus();
		// 	  });
		// 
		// 	  // Create two extra credit fields
		// 	  $('#add').click().click();
	},
	
	
	setupVideos: function() {

    // show form
		$("#add_video").click(function() {
		  $("#new_video").toggle("slow", function() {
				$("#video_code").focus();
			});
		});

	},
	
	setupShowList: function() {

		$(".showblock").hover(
		  function () {
		    $(this).addClass("hover");
		  },
		  function () {
		    $(this).removeClass("hover");
		  }
		);
	},
	
jQuery(function() {

	app.setupAjaxCallbacks();

  // Focus on the first text field
  $("input[type='text']:first").focus();


});