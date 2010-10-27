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

		$("#showdate_start_date, #showdate_start_time," +
		  "#showdate_end_date,   #showdate_end_time")
		    .calendricalDateTimeRange();

		$("#add_showdate").click(function() {
		  $("#new_showdate").toggle("slow");
		});

		$("#showdate_start_date").blur(function() {
		  $("#showdate_end_date").val($("#showdate_start_date").val());
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
	
  getFeed: function () {
		//Set Url of JSON data from the facebook graph api. make sure callback is set with a '?' to overcome the cross domain problems with JSON
		var url = "http://graph.facebook.com/73447773916/posts?limit=22&callback=?";
	
		//Use jQuery getJSON method to fetch the data from the url and then create our unordered list with the relevant data.
		$.getJSON(url,function(json){

			var html = "<ul>";
			
			//loop through and within data array's retrieve the message variable.
			$.each(json.data,function(i,fb){

				html += "<li>";

				switch (fb.type) {

					case "photo":
						html += "<a href='" + fb.link + "' class='left'><img src='" + fb.picture + "' /> </a>";
						break;
						
					case "video":
						html += "<a href='" + fb.link + "' class='left'><img src='" + fb.picture + "' /></a>";
						break;
						
					case "link":
						html += "<a href='" + fb.link + "'>" + fb.name + "</a>";
						break;
				}			

				if (fb.message === undefined) {
					// no message
				} else {
					html += fb.message;	
				}
				html += "<span class='date'>" + fb.created_time + "</span>";
				html += "</li>";
				
			});
			
			html += "</ul>";

			//A little animation once fetched
			$('.facebookfeed').animate({opacity:0}, 700, function(){
					$('.facebookfeed').html(html);
			});
			$('.facebookfeed').animate({opacity:1}, 700);
		});
  }

};

jQuery(function() {

	app.setupAjaxCallbacks();

  // Focus on the first text field
  $("input[type='text']:first").focus();

//	app.gmapInitialize();
	
//	app.codeAddress();
	
//	app.setupShowdates();



});