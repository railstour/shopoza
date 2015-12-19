// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
	$(".payment_options").on("click", "li", function() {
		$(".payment_options li").removeClass("selected_option")
		$(this).addClass("selected_option")
	})
})