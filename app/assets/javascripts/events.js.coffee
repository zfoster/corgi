$(document).ready ->
  if $('body').hasClass('events') && ($('body').hasClass('new') || $('body').hasClass('edit'))
    $('input[id="event_price"]').attr('disabled', true)
    $('input[id="fee_has_charge"]').click ->
      $('input[id="event_price"]').attr('disabled', false)
    $('input[id="fee_no_charge"]').click ->
      $('input[id="event_price"]').attr('disabled', true)
      $('input[id="event_price"]').val(0)
