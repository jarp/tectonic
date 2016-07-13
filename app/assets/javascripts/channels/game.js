App.game = App.cable.subscriptions.create('GameChannel', {
  connected: function(){
    console.log("Channel connected ::> ", this);
  },
  disconnected: function(){
    console.log("Channel disconnected ::> ", this);
  },
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
      Plate.turnOn(cb);
      Plate.enable(cb);
      setTimeout(function(){
        Table.update_points(data.player, data.points)
        }
        , Tectonic.getTimer());
      }
    else if ( data.action == 'lock') {
      Plate.disable(cb);
      Table.join(data.player)
    }

    else if ( data.action == 'join') {
    }
  },

  renderMessage: function(message) {
    return  message;
  }
});
