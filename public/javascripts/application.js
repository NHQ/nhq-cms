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
	
  getFeed: function () {
		//Set Url of JSON data from the facebook graph api. make sure callback is set with a '?' to overcome the cross domain problems with JSON
		var url = "http://graph.facebook.com/73447773916/posts?limit=10&callback=?";
	
		//Use jQuery getJSON method to fetch the data from the url and then create our unordered list with the relevant data.
		$.getJSON(url,function(json){

			var html = "<ul>";
			
			//loop through and within data array's retrieve the message variable.
			$.each(json.data,function(i,fb){

				html += "<li>";
				
				// datestamp
				// var d = new Date(fb.created_time.slice(0,19).replace('T',' ')+' GMT');				
				// html += "<span class='date'>" + String(d).substr(0,15) + " " + "</span>";
				
				// convert facebook created_time to valid Javascript Date
		    // var arrDateTime = fb.created_time.split("T"); 
		    // var strTimeCode = arrDateTime[1].substring(0, arrDateTime[1].indexOf("+")); 
		    // var valid_date = new Date(arrDateTime[0]);
		    // var arrTimeCode = strTimeCode.split(":"); 
		    // valid_date.setHours(arrTimeCode[0]);     
		    // valid_date.setMinutes(arrTimeCode[1]);
		    // valid_date.setSeconds(arrTimeCode[2]);
		
				var created_time = fb.created_time.slice(0,19).replace('T',' ') + ' GMT';

				html += "<span class='date'>" + created_time + " " + "</span>";

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
					html += "<p>" + fb.message + "</p>";	
				}				
				
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


});