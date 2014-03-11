autocomplete = new google.maps.places.Autocomplete(document.getElementById('places-autocomplete'), {})
google.maps.event.addListener autocomplete, 'place_changed', ()->
  place = autocomplete.getPlace()
  console.log place.formatted_address
