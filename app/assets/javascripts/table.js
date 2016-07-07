Table = {
  update_points: function(player, points){
    console.log("updating points", player.first_name, points);
    console.log($("div.ranking[player='"  + player.first_name + " " + player.last_name + "']").html());
    console.log($("div.ranking[player='" + player.first_name + " " + player.last_name +  "']").find('.player-points').html());
    $("div.ranking[player='" + player.first_name + " " + player.last_name + "']").find(".player-points").html(points)
  }
}
