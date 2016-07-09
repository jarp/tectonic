Avatar = {
  load: function(plates) {
    plates.each(function(){
      var target = $(this).find('span.owner');
      var code = $(this).attr('plate_code');
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
        target.css('background-color', '#fff')
        target.css('display', 'block')
        target.css('border', 'thin solid #ccc')
        target.fadeIn('slow', 1)
      })
      .error(function(response){
        Tectonic.handleError(response);
      })
  },

  preload: function(plates) {
    plates.each(function(){
      var target = $(this).find('span.owner');
      var code = $(this).attr('plate_code');

      target.css('background-image', 'url(/assets/images/preloader.gif)')
      target.css('background-color', '')
      target.css('background-size', '36px')
      target.css('border', 'none')
      target.css('opacity', '.8')
      target.css('display', 'block')
      target.fadeIn('slow', 1)
    })
  },

  preUnload: function(plates) {
    plates.each(function(){
      var target = $(this).find('span.owner');
      var code = $(this).attr('plate_code');

      target.css('background-image', 'none')

    })
  }
}
