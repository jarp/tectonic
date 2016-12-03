Plate = {
  disable: function(cb){
    console.log("Disable Plate", cb);
    cb.addClass('processing');
    Avatar.preload(cb);
  },

  enable: function(cb, image){
    cb.removeClass('processing');
    if (image !== '') {
      console.log("its a bonus");
      $('#celebration').addClass(image)
      $('#celebration').addClass('fireworks')
    }
    else{
      console.log('not a bonus');
    }
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
