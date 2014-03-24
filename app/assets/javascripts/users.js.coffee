$(document).ready ->
  $("form.edit_user input[type=radio]").click ->
    $(this).closest('form').submit()

  $('.edit-defaults').click (event) ->
    event.preventDefault()
    $('.default-identity .names').hide()
    $('.edit-defaults').hide()
    $('.email').removeClass('hidden')
    $('.mobile_num').removeClass('hidden')
    $('.save').removeClass('hidden')
