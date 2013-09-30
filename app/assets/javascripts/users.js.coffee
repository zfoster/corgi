setMadiIdentity = (userId, identityId) ->
  $.ajax
    url: "/users/" + userId + "/set_madi_identity"
    type: "get"
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      identity_id: identityId
    success: (result) ->
      $(".default-identity").html result


$(document).ready ->
  $(".user-choose-madi-identity").click ->
    id = $(this).attr("name")
    identity = $(this).val()
    setMadiIdentity id, identity