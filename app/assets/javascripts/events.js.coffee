if $('body').hasClass('events')
  if $('body').hasClass('new')
    seachOptions =
      center: new google.maps.LatLng(43.0667, -89.4000)
      radius: 50000
    autocomplete = new google.maps.places.Autocomplete(document.getElementById('places-autocomplete'), seachOptions)
    google.maps.event.addListener autocomplete, 'place_changed', ()->
      place = autocomplete.getPlace()
      addressArray = place.address_components
      streetNumber = ""
      street = ""
      suiteNumber = ""
      i = 0

      $('#event_meta_location').val(place)
      $('#event_venue_name').val(place.name)
      $('#event_lat').val(place.geometry.location.A)
      $('#event_lon').val(place.geometry.location.k)
      while i < addressArray.length
        if addressArray[i].types[0] is "street_number"
          streetNumber = place.address_components[i].long_name
        if addressArray[i].types[0] is "route"
          street = place.address_components[i].long_name
        if addressArray[i].types[0] is "subpremise"
          suiteNumber = place.address_components[i].long_name
        if addressArray[i].types[0] is "locality"
          $("#event_city").val place.address_components[i].long_name
        i++
      $('#event_street_address').val(streetNumber + " " + street + " " + suiteNumber)

  if $('body').hasClass('edit')

    lat = document.getElementById('event_lat').value
    lon = document.getElementById('event_lon').value

    initialize = ->
      if lat? and lon?
        initialLatLng = new google.maps.LatLng(lon, lat)
      else
        initialLatLng = new google.maps.LatLng(43.0667, -89.4000)
      mapOptions =
        center: initialLatLng
        radius: 50000
        zoom: 14
        mapTypeId: google.maps.MapTypeId.ROADMAP
      searchOptions =
        center: new google.maps.LatLng(43.0667, -89.4000)
        radius: 50000
      map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
      marker = new google.maps.Marker(
        position: initialLatLng
        map: map
      autocomplete = new google.maps.places.Autocomplete(document.getElementById('places-autocomplete'), searchOptions)
      autocomplete.bindTo "bounds", map
      )
      google.maps.event.addListener autocomplete, 'place_changed', ->
        marker.setVisible false
        place = autocomplete.getPlace()
        addressArray = place.address_components
        streetNumber = undefined
        street = undefined
        suiteNumber = undefined
        i = 0

        $('#event_meta_location').val(place)
        $('#event_venue_name').val(place.name)
        $('#event_lat').val(place.geometry.location.A)
        $('#event_lon').val(place.geometry.location.k)
        while i < addressArray.length
          if addressArray[i].types[0] is "street_number"
            streetNumber = place.address_components[i].long_name
          if addressArray[i].types[0] is "route"
            street = place.address_components[i].long_name
          if addressArray[i].types[0] is "subpremise"
            suiteNumber = place.address_components[i].long_name
          if addressArray[i].types[0] is "locality"
            $("#event_city").val place.address_components[i].long_name
          i++
        $('#event_street_address').val(streetNumber + " " + street + " " + suiteNumber)

        if place.geometry.viewport
          map.fitBounds place.geometry.viewport
        else
          map.setCenter place.geometry.location
          map.setZoom 14
        marker.setIcon (
          url: place.icon
          size: new google.maps.Size(71, 71)
          origin: new google.maps.Point(0, 0)
          anchor: new google.maps.Point(17, 34)
          scaledSize: new google.maps.Size(35, 35)
        )
        marker.setPosition place.geometry.location
        marker.setVisible true
        return

      return
    google.maps.event.addDomListener window, "load", initialize
