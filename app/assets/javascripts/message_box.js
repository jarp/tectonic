$(document).ready(function(){

  $('#message-box #close-message-x').click(function(){
    MessageBox.log("clear box")
    MessageBox.clear()
  })

  if ( $('#message-box #message-text').text().trim().length ){
    $('#message-box').fadeIn();
  }

  MessageBox = {
    set: function(msg, format){

      if ( format == 'undefined'){
          format = 'normal';
        }

      this.log("set message as " + format)

      if ( format == 'html'){
        $('#message-box #message-text').html(msg);
      }
      else {
        $('#message-box #message-text').text(msg);
      }

      $('#message-box').fadeIn();

      setTimeout("MessageBox.clear()", 4000);
      },

    clear: function(){
      $('#message-box').fadeOut();
      $('#message-box #message-text').text("");
      },

    log: function(m){
      // console.log(m);
      }
  }
MessageBox.clear();
});
