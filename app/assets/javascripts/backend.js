//= require jquery
//= require jquery_ujs
//= require jquery.countdown
//= require jquery.chained.min
//= require jquery.chained.remote.min
//= require jquery.hoverIntent.minified
//= require jquery.dcmegamenu
//= require jquery.datetimepicker.full.min
//= require jquery-ui/dialog
//= require jquery-fileupload/basic
//= require tmpl.min
//= require ajax

jQuery.datetimepicker.setLocale('zh');

$(document).ready(function(){
  jQuery('.datetimepicker').datetimepicker({
    timepicker:false  });

})
