$(document).ready ->
  if $('body').hasClass('events') && ($('body').hasClass('new') || $('body').hasClass('edit'))
    price_field = $('#event_price')
    fee_radio_button = $('#fee_has_charge')
    no_fee_radio = $('#fee_no_charge')

    price_field.attr('disabled', true)
    fee_radio_button.click ->
      price_field.attr('disabled', false)
    no_fee_radio.click ->
      price_field.attr('disabled', true)
      price_field.val(0)

    jQuery ->
      $( "#datepicker" ).datetimepicker
        stepHour : 1
        stepMinute: 15

      $( "#datepicker2" ).datetimepicker
        stepHour: 1
        stepMinute: 15
