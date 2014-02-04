// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
    $('ul.nav a').click( function() {
            id = $(this).attr('id').substring(3);
            if (id.length > 1) {
                $('#' + id).toggleClass('hidden');
            }
        }
    )
    $('#user-data button').click(function(){
        $('#user-data').toggleClass('hidden');
    })
})  ;