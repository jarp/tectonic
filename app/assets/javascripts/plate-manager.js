Plate = {

  disable: function(cb){
    cb.addClass('processing');
    //cb.attr('disabled', true);
  },

  enable: function(cb){
    cb.removeClass('processing');
    //cb.attr('disabled', false);
  },

  turnOn: function(cb){
    cb.fadeTo('slow', 1);
    cb.removeClass('visibilty-faded');
    cb.removeClass('found');
    //cb.attr('checked', '')
    Avatar.remove(cb);
  },

  turnOff: function(cb){
    cb.fadeTo('slow', .3);
    cb.addClass('found');
    cb.addClass('visibilty-faded');
    //cb.attr('checked','checked')
    Avatar.load(cb);
  }
}
