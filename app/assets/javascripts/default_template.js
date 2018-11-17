$(document).ready(function() {

});
 
$(window).on( "load", function() {
    //debugger
    setTimeout(function() {
        $('textarea#defaulttemplate').val(gon.body_template);
    }, 1000);
    
    if (gon) {
        $('textarea#defaulttemplate').val(gon.body_template);
    }
    
});

