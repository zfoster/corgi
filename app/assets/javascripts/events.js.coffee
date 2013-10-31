$(document).ready ->
  if $('body').hasClass('events') && ($('body').hasClass('new') || $('body').hasClass('edit'))
    price_field = $('#event_price')

    price_field.attr('disabled', true)
    $('#enable_fee').click ->
      if $(this).is(':checked')
        price_field.attr('disabled', false)
      else
        price_field.attr('disabled', true)

    jQuery ->
      $( "#datepicker" ).datetimepicker
        stepHour : 1
        stepMinute: 15
        dateFormat: "DD, M d"
        timeFormat: "hh:mmtt"

      $( "#datepicker2" ).datetimepicker
        stepHour: 1
        stepMinute: 15
        dateFormat: "DD, M d"
        timeFormat: "hh:mmtt"
