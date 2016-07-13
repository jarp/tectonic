
Table = {



  join: function(player){
      console.log("checking if player needs to be added:", player)

      if ( $("div.ranking[player_id='" + player.id + "']").length ){
        console.log("player is already there");
        console.log($("div.ranking[player_id='" + player.id + "']"));
      }

      else {
        console.log('Player needs to be added');
        var rankings = $("#rankings-container");

        html = '<div class="row collapse ranking" player_id="' + player.id + '">'
            + '<div class="small-10 columns player-name">'
            + '<img class="icon" width="64" src="' + player.image +'">'
            + player.first_name
            + '</div> <div class="small-2 columns player-points" player="' + player.first_name + ' ' + player.last_name + '">0</div> </div>'
            rankings.append(html);
      }
  },

  update_points: function(player, points){
    console.log('update points to ', points);
    current_points = $("div.ranking[player_id='" + player.id + "']").find(".player-points").text()

    if ( points == null ){
      console.log('cant remove points');
      points = 0
    }

    Table.spin(
      $("div.ranking[player_id='" + player.id + "']").find(".player-points"),
      current_points,
      points
    );

  },

  spin: function(target, start_at, end_at){
      target.each(function () {
        var $this = $(this);
        jQuery({ Counter: start_at }).animate({ Counter: end_at }, {
          duration: 2000,
          easing: 'swing',
          step: function () {
            $this.text(Math.ceil(this.Counter));
          },
          complete: function(){
            console.log('call table reorder');
            Table.reorder()
          }
        });
      });

  },

  reorder: function(){
    console.log("table.reorder on its own called");
    var rankings = $("#rankings-container");
    var store = [];

    rankings.find('.ranking').each(function(){
        var row = $(this);
        var player_id = row.attr('player_id')
        var sortnr = parseFloat(row.find(".player-points").text());
        // console.log('storing indie row',  player_id, row.html());
        // console.log("sorter nubmer is ", sortnr);
        if(!isNaN(sortnr)){
          store.push([sortnr, player_id, row.html()]);
        }
    })

    store.sort(function(x,y){
        return y[0] - x[0];
    });

    rankings.html("");

    for(var i=0, len=store.length; i<len; i++){
        rankings.append('<div class="row collapse ranking" player_id="' + store[i][1] + '">' + store[i][2] + '</div>');
    }
    store = null;
  }
}
