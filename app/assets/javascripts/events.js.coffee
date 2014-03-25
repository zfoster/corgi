$('.date-picker').datetimepicker({pickTime: false});

$('#event_start_time_date').on 'change', ()->
    $('#event_end_time_date').val($(this).val())

if $('body').hasClass('events')
  if $('body').hasClass('new')
    seachOptions =
      center: new google.maps.LatLng(43.0667, -89.4000)
      radius: 50000
    autocomplete = new google.maps.places.Autocomplete(document.getElementById('places-autocomplete'), seachOptions)
    google.maps.event.addListener autocomplete, 'place_changed', ()->
      place = autocomplete.getPlace()
      addressArray = place.address_components
      i = 0

      $('#event_lat').val(place.geometry.location.A)
      $('#event_lon').val(place.geometry.location.k)
      while i < addressArray.length
        if addressArray[i].types[0] is "locality"
          $("#event_city").val place.address_components[i].long_name
          break
        i++

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
      # infowindow = new google.maps.InfoWindow()
      marker = new google.maps.Marker(
        position: initialLatLng
        map: map
      autocomplete = new google.maps.places.Autocomplete(document.getElementById('places-autocomplete'), searchOptions)
      autocomplete.bindTo "bounds", map
      )
      google.maps.event.addListener autocomplete, 'place_changed', ->
        # infowindow.close()
        marker.setVisible false
        place = autocomplete.getPlace()
        addressArray = place.address_components
        i = 0

        $('#event_lat').val(place.geometry.location.A)
        $('#event_lon').val(place.geometry.location.k)
        while i < addressArray.length
          if addressArray[i].types[0] is "locality"
            $("#event_city").val place.address_components[i].long_name
            break
          i++

        if place.geometry.viewport
          map.fitBounds place.geometry.viewport
        else
          map.setCenter place.geometry.location
          map.setZoom 14 # Why 17? Because it looks good.
        marker.setIcon (
          url: place.icon
          size: new google.maps.Size(71, 71)
          origin: new google.maps.Point(0, 0)
          anchor: new google.maps.Point(17, 34)
          scaledSize: new google.maps.Size(35, 35)
        )
        marker.setPosition place.geometry.location
        marker.setVisible true

        # address = ""
        # if place.address_components
        #   address = [
        #     place.address_components[0] and place.address_components[0].short_name or ""
        #     place.address_components[1] and place.address_components[1].short_name or ""
        #     place.address_components[2] and place.address_components[2].short_name or ""
        #   ].join(" ")
        # infowindow.setContent "<div><strong>" + place.name + "</strong><br>" + address
        # infowindow.open map, marker
        return

      return
    google.maps.event.addDomListener window, "load", initialize
