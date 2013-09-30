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
    url: '/users/' + id + '/set_mobile_num'
    type: 'get'
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      user:
        mobile_num: number


$(document).ready ->
  $(".user-choose-madi-identity").click ->
    id = $(this).attr("name")
    identity = $(this).val()
    setMadiIdentity id, identity
  $('.user-mobile-num').bind "keyup paste", ->
    setTimeout 500
    id = $(this).attr('id')
    number = $(this).val()
    setMobileNumber id, number