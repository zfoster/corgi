$(document).ready ->
  $("form.edit_user input[type=radio]").click ->
    $(this).closest('form').submit()

  $('.edit-default-email').click (event) ->
    event.preventDefault()
    $('.default-identity .names').hide()
    $('.email').show()
    $('.save').show()

  $('.edit-default-mobile').click (event) ->
    event.preventDefault()
    $('.default-identity .names').hide()
    $('.mobile_num').show()
    $('.save').show()
