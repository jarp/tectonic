

$(document).ready(function(){
  if ( $("#play").length > 0 ){
      console.log('xs-play js lib')

  Avatar.load( $('.plate.found') )


  $('.plate').on('click', function(){
    var plate = $(this).attr('plate_code');

    if( $(this).hasClass('found') ) {
      //Plate.turnOn($(this), $(this))
      delete_find(plate, $(this))
    }
    else{
      lock(plate, $(this));
      update(plate, $(this) )
    }

  })


  function update(plate, cb){
    Plate.disable(cb);
    navigator.geolocation.getCurrentPosition(
      function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        }
        coord_as_string =  position.coords.latitude + "|" + position.coords.longitude
        console.log('got location: coord_as_string', coord_as_string)
        post_update(plate, cb, coord_as_string)
      }
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
        .success(function(response){
        })
        .error(function(response){
          Tectonic.handleError(response);
          cb.find('span.owner').fadeOut();
          cb.css('border', 'none');
        })
  }

    function post_update(plate, cb, coords){
      var jqxhr = $.ajax({
          type: "POST",
          url: '/finds/',
          dataType: 'JSON',
          data: {
            code: plate,
            current_location: coords
          }
          })
          .success(function(response){
            Plate.enable(cb);
            Plate.turnOff(cb);
          })
          .error(function(response){
            console.log("error response is ", response)
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
