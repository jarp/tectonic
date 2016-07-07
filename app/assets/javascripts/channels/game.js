App.game = App.cable.subscriptions.create('GameChannel', {
    connected: function(){
      console.log('connected to game channel');
    }
    ,
    received: function(data) {
      console.log('getting messages from ws', data);
      //console.log($("#play").html());
      if (data.message !== undefined){
        MessageBox.set( this.renderMessage(data.message), 'html');
      }

      cb = $("div[plate_code='"+ data.state + "']")

      if (data.action == 'find'){
        // console.log('turn off', cb.val());
        Plate.turnOff(cb);
        Plate.enable(cb);
        Table.update_points(data.player, data.points);
      }

      else if (data.action == 'clear'){
        // console.log('turn ON', cb.val());
        Plate.turnOn(cb);
        Plate.enable(cb);
        Table.update_points(data.player, data.points);
      }
      else if ( data.action == 'lock') {
        console.log("disable this plate~");
        Plate.disable(cb);
      }
    },

    renderMessage: function(message) {
      return "<b>Update:</b> " + message;
    }
  });

  // function turnOn(cb){
  //   cb.parent().fadeTo('slow', 1);
  //   cb.parent().removeClass('visibilty-faded');
  //   cb.prop('checked', false)
  //   removeAvatars(cb.parent());
  //
  // }
  //
  // function turnOff(cb){
  //   cb.parent().fadeTo('slow', .3);
  //   cb.parent().addClass('visibilty-faded');
  //   loadAvatars(cb.parent());
  //   cb.attr('checked','checked')
  // }
