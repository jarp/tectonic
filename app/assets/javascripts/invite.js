$(document).ready(function(){

  $(document)
  .on("ajax:success", "#invite_form", function(status, data, xhr) {
    //  $('#player-list').append("<li class='player'>" + $('#invite_field').val() + " [ " + data.token + "]</li>")
    var game_id = $('#player-list').attr('game_id')
    console.log('load game players', game_id);
    loadPlayers(game_id)
     $('#invite_field').val("")
   })
   .on("ajax:error", "#invite_form", function(status, data, xhr) {
     alert('Could not add player')
    })
   ;

   $(document)
   .on("ajax:success", ".button_to", function(status, data, xhr) {
     var game_id = $('#player-list').attr('game_id')
     console.log('load game players', game_id);
     loadPlayers(game_id)
    })
    .on("ajax:error", ".button_to", function(status, data, xhr) {
      alert('Could not remove player')
     })
    ;

   if ( $("#player-list").length > 0 ){
     console.log('jq')
     var game_id = $('#player-list').attr('game_id')

     loadPlayers(game_id);

     function loadPlayers(game_id){
       console.log('load')
       $('#player-list').load('/game_players?game_id=' + game_id)
     }
   }
});
