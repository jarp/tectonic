$(document).ready(function(){

  Avatar.load( $('.plate.found') )

  $('input.control-toggle').on('change', function(){

    var plate = $(this).val();

    if( $(this).is(':checked') ) {
      lock(plate, $(this));
      update(plate, $(this) )
    }
    else{
      Plate.turnOn($(this).parent(), $(this))
      delete_find(plate, $(this))
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
        post_update(plate, cb, coord_as_string)
      }
    )

  }

  function lock(plate, cb){
    console.log("lock the plate!");
    var jqxhr = $.ajax({
        type: "POST",
        url: '/finds/lock',
        dataType: 'JSON',
        data: {
          code: plate
        }
        })
        .success(function(response){
          console.log("lock >> success // response: ", response)
        })
        .error(function(response){
          console.log("error response is ", response)
          alert('An error occured')

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
            console.log("post update >> success // response: ", response)
            Plate.enable(cb);
            Plate.turnOff(cb);
          })
          .error(function(response){
            console.log("error response is ", response)
            Plate.enable(cb);
            Plate.turnOn(cb);
            alert('An error occured')

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
            // console.log("success response is ", response)
            Plate.turnOn(cb)
          })
          .error(function(response){
            console.log("error response is ", response)
            alert('An error occured')
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


})
