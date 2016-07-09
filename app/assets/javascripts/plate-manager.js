Plate = {
  disable: function(cb){
    cb.addClass('processing');
    Avatar.preload(cb);
  },

  enable: function(cb){
    cb.removeClass('processing');
  },

  turnOn: function(cb){
    cb.fadeTo('slow', 1);
    cb.removeClass('visibilty-faded');
    cb.removeClass('found');
    Avatar.remove(cb);
  },

  turnOff: function(cb){
    cb.fadeTo('slow', .3);
    cb.addClass('found');
    cb.addClass('visibilty-faded');
    Avatar.load(cb);
  }
}
