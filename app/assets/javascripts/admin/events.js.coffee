autocomplete = new google.maps.places.Autocomplete(document.getElementById('places-autocomplete'), {})
google.maps.event.addListener autocomplete, 'place_changed', ()->
  place = autocomplete.getPlace()
  $('#event_lat').val(place.geometry.location.A)
  $('#event_lon').val(place.geometry.location.k)
