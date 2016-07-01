$(document).ready(function(){

  $('input.control-toggle').on('change', function(){

    var plate = $(this).val();
    console.log($(this).val());

    if( $(this).is(':checked') ) {
      $(this).parent().fadeTo('slow', .3);
      $(this).parent().addClass('visibilty-faded');
      update(plate)
    }

    else{
      $(this).parent().fadeTo('slow', 1);
      $(this).parent().removeClass('visibilty-faded');
    }

  })

  function update(plate){
    var jqxhr = $.ajax({
        type: "POST",
        url: '/finds/',
        dataType: 'JSON',
        data: {
            code: plate
          }
        })
        .success(function(response){
          //messageBox.set("comment has been submitted.")
          //refresh()
          console.log(response)


        })
        .error(function(response){
          console.log(response)
          alert('An error occured')
        })
    }

})
