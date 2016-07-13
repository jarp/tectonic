$(document)
.on("ajax:success", "#invite_form", function(status, data, xhr) {
   $('#player-list').append("<li class='player'>" + $('#invite_field').val() + " [ " + data.token + "]</li>")
   $('#invite_field').val("")
 })
 .on("ajax:error", "#invite_form", function(status, data, xhr) {
  })
 ;
