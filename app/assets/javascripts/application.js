// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require tether 
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks 
//= require_tree .
//Reference: https://jsfiddle.net/fwv18zo1/

//Logic for the category and subcategory dynamic dropdowns
jQuery(function() {
  var subcategories;
  subcategories = $('#product_subcategory').html();
  console.log(subcategories);
  return $('#product_category').change(function() {
    var category, options;
    category = $('#product_category :selected').text();
    options = $(subcategories).filter("optgroup[label=" + category + "]").html();
    console.log(options);
    if (options) {
      return $('#product_subcategory').html(options);
    } else {
      return $('#product_subcategory').empty();
    }
  });
});

 function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#blah')
                        .attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
