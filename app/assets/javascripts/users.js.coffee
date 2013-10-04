setMadiIdentity = (userId, identityId) ->
  $.ajax
    url: "/users/" + userId + "/set_madi_identity"
    type: "get"
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      identity_id: identityId
    success: (result) ->
      $(".default-identity").html result
setMobileNumber = (id, number) ->
  $.ajax
    url: '/users/' + id + '/update_user_data'
    type: 'post'
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      user:
        mobile_num: number
    success: 
      $('.default-card-info .number-number').text(number)
setEmailAddress = (id, email) ->
  $.ajax
    url: '/users/' + id + '/update_user_data'
    type: 'post'
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      user:
        email: email
    success: 
      $('.default-card-info .name-name').text(email.substring(0,17) + "...")

$(document).ready ->
  $(".user-choose-madi-identity").click ->
    id = $(this).attr("name")
    identity = $(this).val()
    setMadiIdentity id, identity
  $('.edit-default-email').click ->
    $('.default-card-info').css('display', 'none');
    $('#default-email-edit').css('display', 'block');
  $('.edit-default-mobile').click ->
    $('.default-card-info').css('display', 'none');
    $('#default-mobile-edit').css('display', 'block');
  $('.save-email').click (event) ->
    id = $(this).attr("user-id")
    email = $('#edited-email').val()
    setEmailAddress id, email
    history.pushState("", document.title, window.location.pathname);
    $('#default-email-edit').css('display', 'none');
    $('.default-card-info').css('display', 'block');
  $('.save-mobile').click (event) ->
    id = $(this).attr("user-id")
    number = $('#edited-mobile').val()
    setMobileNumber id, number
    history.pushState("", document.title, window.location.pathname);
    $('#default-mobile-edit').css('display', 'none');
    $('.default-card-info').css('display', 'block');
