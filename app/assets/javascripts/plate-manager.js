
  function disable(cb){
    cb.parent().addClass('processing');
    cb.attr('disabled', true);
  }


  function enable(cb){
    cb.parent().removeClass('processing');
    cb.attr('disabled', false);
  }

  function turnOn(cb){
    cb.parent().fadeTo('slow', 1);
    cb.parent().removeClass('visibilty-faded');
    cb.attr('checked', '')
    removeAvatars(cb.parent());
  }

  function turnOff(cb){
    console.log("turning of plate card", cb );
    cb.parent().fadeTo('slow', .3);
    cb.parent().addClass('visibilty-faded');
    cb.attr('checked','checked')
    loadAvatars(cb.parent());
  }
