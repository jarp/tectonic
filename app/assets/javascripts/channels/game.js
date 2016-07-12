App.game = App.cable.subscriptions.create('GameChannel', {
    connected: function(){
    console.log('connected to game channel with', this);
    }
    ,
    received: function(data) {
      if (data.message !== undefined){
        MessageBox.set( this.renderMessage(data.message), 'html');
      }

      console.log("cabel data is ", data);

      cb = $("div[plate_code='"+ data.state + "']")

      if (data.action == 'find'){
        Plate.turnOff(cb);
        Plate.enable(cb);
        setTimeout(function(){Table.update_points(data.player, data.points)}
          , Tectonic.getTimer());}

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
    //    console.log("disable: ", cb);
        Plate.disable(cb);
      }

      else if ( data.action == 'join') {
      //  console.log("join: ", data);
        Table.join(data.player);
      }
    },

    renderMessage: function(message) {
      return  message;
    }
  });
