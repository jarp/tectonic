// app/assets/javascripts/channels/messages.js

  App.messages = App.cable.subscriptions.create('PlayChannel', {
    received: function(data) {
      //console.log('getting messages from ws', data);
      //console.log($("#play").html());
      MessageBox.set( this.renderMessage(data), 'html');
      cb = $('input').filter('#' + data.state + "-control")
      if (data.action == 'find'){
        // console.log('turn off', cb.val());
        turnOff(cb);
        enable(cb);
      }

      else if (data.action == 'clear'){
        // console.log('turn ON', cb.val());
        turnOn(cb);
        enable(cb);
      }
      else if ( data.action == 'lock') {
        console.log("disable this plate~");
        disable(cb);
      }
    },

    renderMessage: function(data) {
      return "<b>Update:</b> " + data.message;
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