$(document).ready(function(){

  loadAvatars( $('.plate.found') )

  $('input.control-toggle').on('change', function(){

    var plate = $(this).val();

    if( $(this).is(':checked') ) {
      update(plate, $(this) )
    }

    else{
      turnOn($(this).parent(), $(this))
      delete_find(plate, $(this))
    }

  })

  function turnOn(cb){
    cb.parent().fadeTo('slow', 1);
    cb.parent().removeClass('visibilty-faded');
    cb.attr('checked', '')
    removeAvatars(cb.parent());

  }

  function turnOff(cb){
    cb.parent().fadeTo('slow', .3);
    cb.parent().addClass('visibilty-faded');
    //loadAvatars(cb.parent());
    cb.attr('checked','checked')
  }

  function update(plate, cb){
    var jqxhr = $.ajax({
        type: "POST",
        url: '/finds/',
        dataType: 'JSON',
        data: { code: plate }
        })
        .success(function(response){
          // console.log("success response is ", response)
          turnOff(cb)
        })
        .error(function(response){
          console.log("error response is ", response)
          turnOn(cb)
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
            turnOn(cb)
          })
          .error(function(response){
            console.log("error response is ", response)
            alert('An error occured')
            turnOff(cb)
          })
      }

})
