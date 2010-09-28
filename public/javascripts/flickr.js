var apiKey = '294853dd9279038f6b50085edb0909d8';
var userID = '46243930@N03';
$(document).ready(function(){
	$.getJSON('http://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=' + apiKey + '&user_id=' + userID + '&format=json&jsoncallback=?', function(data){
		$.each(data.photosets.photoset, function(i, item){
			var psid = item.id;
			$.each(item.title, function(){
				var titres = this;
				$('<li id='+ psid + '><a href="#">' + titres + '</a></li>' ).appendTo("ul.flickr-list");
			});
		});
	});
});

$('li').live('click', function(event){
	$('ul').hide('fast');
	$('div.images').empty();
	var psid2 = $(this).attr('id');
	$.getJSON('http://api.flickr.com/services/rest/?&method=flickr.photosets.getPhotos&api_key=' + apiKey + '&photoset_id=' + psid2 + '&format=json&jsoncallback=?', function(data){
		var pid = $(data.photoset.photo).attr('id');
		$.each(data.photoset.photo, function(i,item){
			var photoURL = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_m.jpg';
			$('<input class="fimg" type="checkbox" checked id="' + item.secret + '" name="event[flickr][]" value="' + photoURL + '"><label for="' + item.secret + '"><a><img src="' + photoURL + '"/></a></label></input><br />').appendTo('div.images').css({'float' : 'right', 'clear' : 'left'}).click(function(){$(this).toggleClass('newB')});
		});
	});
});

$('input.fimg').live('click', function() {
	$("div.img").toggleClass('newClass');
});

$(function() {
	$('#butts').buttonset();	
});