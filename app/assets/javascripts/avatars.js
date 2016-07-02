function loadAvatars(plates){
  plates.each(function(){
    var target = $(this).find('span');
    var code = $(this).find('input').val();
    // console.log("get avatar for ", code, target);
    getAvatar(code,target);
  })
}

function removeAvatars(plates){
  plates.each(function(){
    var target = $(this).find('span');
    var code = $(this).find('input').val();
    target.css('background-image', '')
    target.css('background-size', '')
    target.fadeOut('fast')
  })
}



function getAvatar(code, target){
  var jqxhr = $.ajax({
      type: "get",
      url: '/finds/avatar/'+ code
      })
      .success(function(response){
        //console.log('returning avator: ' + response);
        target.css('background-image', 'url('+ response + ')')
        target.css('background-size', '36px')
        target.css('display', 'block')
        target.fadeIn('slow', 1)
      })
      .error(function(response){
        console.log("error response is ", response)
      })
  }
