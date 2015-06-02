// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require autocomplete-rails
//= require turbolinks
//= require bootstrap-sprockets
//= require select2
//= require chartkick
//= require jquery-ui/datepicker
//= require jquery-ui/datepicker-fr
//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require moment/fr
//= require_tree .

$(document).on("page:load ready", function(){
    //$("input.datepicker").datepicker();
    //$(".datepicker").datepicker();
    //
    //$.datepicker.setDefaults( $.datepicker.regional[ "fr" ] );

    //$('.datetimepicker').datetimepicker();

});
jQuery(document).on('page:load', function() {
    var s = document.createElement("script");
    s.type = "text/javascript";
    s.async = true;
    s.src = '//api.usersnap.com/load/'+'82ebb367-d63d-4ea3-b98f-8e64b2a42549.js';
    var x = document.getElementsByTagName('script')[0];
    x.parentNode.insertBefore(s, x);
});