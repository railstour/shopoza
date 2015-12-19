// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
	$(".payment_options").on("click", "li a", function() {
		// set the current option to selected_option
		$(".payment_options li").removeClass("selected_option")
		$(this).addClass("selected_option")

		// display the form
      $(".payment_option_forms .payment_form").removeClass("selected_option")
      form_class = ".payment_form" + "." + $(this).attr("id")
		$(".payment_option_forms")
         .find(form_class)
         .addClass("selected_option")
	})
})