# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
   $(".avatar").click ->
    avatar = $(this).attr("value")
    userId = $(this).attr("data-id")
    alert userId
    alert avatar
    setDefaultAvatar(avatar, userId)
    

setDefaultAvatar = (avatar, userId) ->
  $.ajax
    url: "/users/" + userId + "/set_default_avatar"
    type: "POST"
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data: 
      avatar: avatar
