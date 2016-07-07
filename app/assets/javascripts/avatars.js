Avatar = {
  load: function(plates) {
    plates.each(function(){
      var target = $(this).find('span');
      var code = $(this).attr('plate_code');
      // console.log("get avatar for ", code, target);
      Avatar.get(code,target);
    })
  },

remove: function(plates){
  plates.each(function(){
    var target = $(this).find('span');
    var code = $(this).find('input').val();
    target.css('background-image', '')
    target.css('background-size', '')
    target.fadeOut('fast')
  })
},

get: function(code, target){
  var jqxhr = $.ajax({
      type: "get",
      url: '/finds/avatar/'+ code
      })
      .success(function(response){
        target.css('background-image', 'url('+ response + ')')
        target.css('background-size', '36px')
        target.css('display', 'block')
        target.fadeIn('slow', 1)
      })
      .error(function(response){
        console.log("error response is ", response)
      })
  }
}
