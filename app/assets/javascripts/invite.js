$(document)
.on("ajax:success", "#invite_form", function(status, data, xhr) {
   console.log("success", data);

   $('#player-list').append("<li class='player'>" + $('#invite_email') + "</li>")
   $('#invite_email').val("");
 });
