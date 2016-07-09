App.game = App.cable.subscriptions.create('GameChannel', {
    connected: function(){
      console.log('connected to game channel with');
    }
    ,
    received: function(data) {
      if (data.message !== undefined){
        MessageBox.set( this.renderMessage(data.message), 'html');
      }

      cb = $("div[plate_code='"+ data.state + "']")

      if (data.action == 'find'){
        // console.log('turn off', cb.val());
        Plate.turnOff(cb);
        Plate.enable(cb);

        setTimeout(function(){
          Table.update_points(data.player, data.points)
          }
          , Tectonic.getTimer());
          }



      else if (data.action == 'clear'){
        // console.log('turn ON', cb.val());
        Plate.turnOn(cb);
        Plate.enable(cb);
        setTimeout(function(){
          Table.update_points(data.player, data.points)
          }
          , Tectonic.getTimer());


      }
      else if ( data.action == 'lock') {
        Plate.disable(cb);
      }
    },

    renderMessage: function(message) {
      return  message;
    }
  });
