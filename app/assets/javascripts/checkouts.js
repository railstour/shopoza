// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
  if ($(".payment_options").length > 0) {
    // Set Veritrans client key
    Veritrans.client_key = window.veritransClientKey
    Veritrans.url = "https://api.sandbox.veritrans.co.id/v2/token"

    // when clicking a payment option, display the form
    $(".payment_options").on("click", "li a", function(event) {
      event.preventDefault()

      // set the current option to selected_option
      $(".payment_options li").removeClass("selected_option")
      $(this).addClass("selected_option")

      // display the form
      $(".payment_option_forms .payment_form").removeClass("selected_option")
      formClass = ".payment_form" + "." + $(this).attr("id")
      $(".payment_option_forms")
      .find(formClass)
      .addClass("selected_option")
    })

    // == for mandiri only
    $(".payment_option_forms .pay_manclick #card_number").on("keyup", function() {
      ccNumber = $(this).val()
      if (ccNumber.length > 9) {
        $("#input1").val(ccNumber.substring(ccNumber.length, ccNumber.length - 10))
      }
    })

    // generate random number
    $("#input3").val(function() {
      var pad = new Array(1 + 5).join(0)
      return (pad + Math.floor(Math.random() * 99999)).slice(-pad.length)
    }())
    // == end for mandiri only

    // == for credit card only
    var card = function() {
      return {
        'card_number': $("#cc_card_number").val(),
        'card_exp_month': $("#cc_card_exp_month").val(),
        'card_exp_year': $("#cc_card_exp_year").val(),
        'card_cvv': $("#cc_card_cvv").val()
      }
    }

    $(".payment_option_forms .pay_cc input[type='submit']").on("click", 
      function(event) {
        event.preventDefault()
        Veritrans.token(card, function callback(response) {
          if (response.status_code == '200') {
            $("#cc_token_id").val(response.token_id)
            $.ajax({
              type: "POST",
              url: $(".payment_option_forms .pay_cc").attr("action"),
              data: {
                'payment_type': 'credit_card',
                'credit_card': {
                  'token_id': $("#cc_token_id").val()
                }
              },
              beforeSend: function() {
                window.openSpinner()
              },
              complete: function(e) {
                window.closeSpinner()
                response = e.responseJSON
                if (response.success == 1 || response.success == '1') {
                  window.location = "/"
                } else {
                  alert("There is an error in checking out. Please contact us Admin")
                }
              },
            })
            $(".payment_option_form .pay_cc form").submit()
          } else {
            alert(response.status_message)
            console.log(JSON.stringify(response))
          }
        })
    })
    $("#cc_card_number").makeCreditCardField()
    // == end for credit card only
  }
})
