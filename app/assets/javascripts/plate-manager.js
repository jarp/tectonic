Plate = {


  disable: function(cb){
    cb.parent().addClass('processing');
    cb.attr('disabled', true);
  },

  enable: function(cb){
    cb.parent().removeClass('processing');
    cb.attr('disabled', false);
  },

  turnOn: function(cb){
    cb.parent().fadeTo('slow', 1);
    cb.parent().removeClass('visibilty-faded');
    cb.attr('checked', '')
    Avatar.remove(cb.parent());
  },

  turnOff: function(cb){
    console.log("turning of plate card", cb );
    cb.parent().fadeTo('slow', .3);
    cb.parent().addClass('visibilty-faded');
    cb.attr('checked','checked')
    Avatar.load(cb.parent());
  }
}
