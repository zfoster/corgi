userWriteInEmail = (elementName) ->
  email = elementName
  userId = $(".user-choose-email").attr("name").substr(6)
  setEmail email, userId
userSetEmail = (elementName) ->
  email = $("input:radio[name=" + elementName + "]:checked").val()
  userId = $(".user-choose-email").attr("name").substr(6)
  setEmail email, userId
setEmail = (email, userId) ->
  $.ajax
    url: "/users/set_email"
    type: "POST"
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      id: userId
      user:
        email: email
    success: (result) ->
      $(".user-show-email").html email


$(document).ready ->
  $(".user-choose-email").click ->
    elementName = $(this).attr("name")
    userSetEmail elementName
  $(".user-write-in-email").bind "keyup paste", ->
    setTimeout 500
    elementName = $(this).val()
    userWriteInEmail elementName
