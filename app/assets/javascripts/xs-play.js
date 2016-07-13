$(document).ready(function(){
  if ( $("#play").length > 0 ){

    Avatar.load( $('.plate.found') )

    $('.plate').on('click', function(){
      var plate = $(this).attr('plate_code');
      var plate_id = $(this).attr('plate_id');

      if( $(this).hasClass('found') ) {
        delete_find(plate, $(this))
      }
      else{
        lock(plate, $(this));
        update(plate, plate_id, $(this) )
      }
    })


    function update(plate, plate_id, cb){
      Plate.disable(cb);
      var options = {
        enableHighAccuracy: true,
        timeout: 5000
      };

      navigator.geolocation.getCurrentPosition(
        function(position) {
          var pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          }
          coord_as_string =  position.coords.latitude + "|" + position.coords.longitude
          post_update(plate, plate_id, cb, coord_as_string)
        },
        function(response){},
        options
      )
    }

    function lock(plate, cb){
      var jqxhr = $.ajax({
        type: "POST",
        url: '/finds/lock',
        dataType: 'JSON',
        data: {
          code: plate
          }
        })
        .success(function(response){})
        .error(function(response){
          Tectonic.handleError(response);
          cb.find('span.owner').fadeOut();
          cb.css('border', 'none');
        })
      }

      function post_update(plate, plate_id, cb, coords){
        var jqxhr = $.ajax({
          type: "POST",
          url: '/finds/',
          dataType: 'JSON',
          data: {
            code: plate,
            plate_id: plate_id,
            current_location: coords
            }
          })
          .success(function(response){
            Plate.enable(cb);
            Plate.turnOff(cb);
          })
          .error(function(response){
            Plate.enable(cb);
            Plate.turnOn(cb);
            Tectonic.handleError(response);
          })
        }

      function delete_find(plate, cb){
        var jqxhr = $.ajax({
          type: "POST",
          url: '/finds/clear',
          dataType: 'JSON',
          data: { code: plate }
          })
          .success(function(response){
            Plate.turnOn(cb)
          })
          .error(function(response){
            Tectonic.handleError(response);
            Plate.turnOff(cb)
          })
        }

        function getLocation(){
          navigator.geolocation.getCurrentPosition( function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            }
            return position.coords.latitude + "::" + position.coords.longitude
          }
      )};
    }
})
