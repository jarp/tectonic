// app/assets/javascripts/channels/messages.js

  App.messages = App.cable.subscriptions.create('PlayChannel', {
    received: function(data) {
      //console.log('getting messages from ws', data);
      //console.log($("#play").html());
      MessageBox.set( this.renderMessage(data), 'html');
      cb = $('input').filter('#' + data.state + "-control")
      console.log('turn off', cb.val());
      turnOff(cb);
    },

    renderMessage: function(data) {
      return "<b>Update:</b> " + data.message;
    }
  });

  function turnOn(cb){
    cb.parent().fadeTo('slow', 1);
    cb.parent().removeClass('visibilty-faded');
    cb.attr('checked',' ')

  }

  function turnOff(cb){
    cb.parent().fadeTo('slow', .3);
    cb.parent().addClass('visibilty-faded');
    cb.attr('checked','checked')
  }
