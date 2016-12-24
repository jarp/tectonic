
Table = {

  join: function(player){

      if ( $("div.ranking[player_id='" + player.id + "']").length ){
      }

      else {
        var rankings = $("#rankings-container");

        html = '<li><div class="row collapse ranking select-player" player_id="' + player.id + '">'
          + '<div class="small-6 medium-4 columns player-image">'
          + '<img class="icon player-icon player-image" width="64" src="' + player.image +'">'
          + '</div>'
          + '<div class="small-6 columns medium-2 player-points right medium-text-right" player="' + player.first_name + ' ' + player.last_name + '">0</div>'
          + '<div class="small-12 medium-6 columns player-name hide-for-small-only" player="' + player.first_name + ' ' + player.last_name + '">'
          + player.first_name
          + '</div>'
          + '</div></li>'

            rankings.append(html);
      }
  },

  update_points: function(player, points){
    current_points = $("div.ranking[player_id='" + player.id + "']").find(".player-points").text()
    current_team_points = $("div#team-points").text()

    console.log("CURRENT TO POINTS from '" + current_points + "' points");
    console.log("team to points '" +  current_team_points +   "' points");

    if ( points == null ){
      points = 0
    }

    Table.spin(
      $("div.ranking[player_id='" + player.id + "']").find(".player-points"),
      current_points,
      points
    );

    Table.spin(
      $("div#team-points"),
      current_team_points,
      points
    );

  },

  spin: function(target, start_at, end_at){
    console.log("spinning" target);
    console.log("from " + start_at + " to " + end_at);
    if ( start_at < end_at ){
      var dir = 'up'

    }
    else {
      var dir = 'down'
    }


      target.each(function () {
        var $this = $(this);
        if ( dir == 'up'){
          $this.addClass('going-up');
        }
        else{
          $this.addClass('going-down');
        }

        jQuery({ Counter: start_at }).animate({ Counter: end_at }, {
          duration: 2000,
          easing: 'swing',
          step: function () {
            $this.text(Math.ceil(this.Counter));
          },
          complete: function(){
            Table.reorder()
          }
        });
      });

  },

  reorder: function(){
    var rankings = $("#rankings-container");
    var store = [];

    rankings.find('.ranking').each(function(){
        var row = $(this);
        var player_id = row.attr('player_id')
        var sortnr = parseFloat(row.find(".player-points").text());
        if(!isNaN(sortnr)){
          store.push([sortnr, player_id, row.html()]);
        }
    })

    store.sort(function(x,y){
        return y[0] - x[0];
    });

    rankings.html("");

    for(var i=0, len=store.length; i<len; i++){
        rankings.append('<li><div class="row collapse ranking" player_id="' + store[i][1] + '">' + store[i][2] + '</div></li>');
    }

    $('.going-up').removeClass('going-up');
    $('.going-down').removeClass('going-down');
    store = null;
  }
}
