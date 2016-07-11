$(document)
.on("ajax:success", "#invite_form", function(status, data, xhr) {
  console.log(status, data, xhr);
   $('#player-list').append("<li class='player'>" + $('#invite_email').val() + "</li>")
   $('#invite_email').val("");
 })
 .on("ajax:error", "#invite_form", function(status, data, xhr) {
   console.log('player failed!')
   console.log(status,data);
  })
 ;
