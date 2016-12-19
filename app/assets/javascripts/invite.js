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
     var game_id = $('#player-list').attr('game_id')

     loadPlayers(game_id);

     function loadPlayers(game_id){
       $('#player-list').load('/game_players?game_id=' + game_id, function(){
         console.log('get player count');
         var game_id = $('#player-list').attr('game_id')
         var jqxhr = $.ajax({
           type: "GET",
           url: '/game_players/' + game_id + '/count',
           dataType: 'JSON'
           })
           .success(function(response){
             console.log("player coutn resuel",response);
             if (response > 3 ){
               console.log('close it out');
               toggleInviteForm('hide')
             }
             else{
               toggleInviteForm('show')
             }
           })
           .error(function(response){
           })
       })
     }

     function toggleInviteForm(action){
       if (action == 'show'){
         $('#invite-players form#invite_form').fadeIn()
         $('#invite-players #closed-message').html('<p>You have reached the limit of 4 players</p>').fadeOut()
       }

       else {
         $('#invite-players form#invite_form').fadeOut()
         $('#invite-players #closed-message').html('<p>You have reached the limit of 4 players</p>').fadeIn()
       }
     }
   }
});
