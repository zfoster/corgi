# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
   $(".avatar").click ->
    avatarUrl = $(this).attr("name")
    

setDefaultAvatar = (avatarUrl) ->
  $.ajax
    url: "/users/" + current_user.id + "/set_default_avatar"
    type: "POST"
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    data:
      avatar: avatarUrl 
