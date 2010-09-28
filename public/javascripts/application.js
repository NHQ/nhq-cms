// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// $('form a.add_record').live('click', function() {  
//   var assoc   = $(this).attr('data-model');                 // Name of model
//   var content = $('#' + assoc + '_fields_template').html(); // Fields template
//   
//   // Make a unique ID for the new record
//   var regexp = new RegExp('new-id-here', 'g');
//   var new_id = new Date().getTime();
//   content = content.replace(regexp, new_id);
//     
//   // inject the content into the page
//   $(this).parent().before(content);
//   
// 	return false;
// });
// 
// $('form a.remove_record').live('click', function() {
//   $(this).closest('.new_fields').remove();
//   return false;
// });