Tectonic = {

  handleError: function(response){
    console.log("error response is ", response)

    if ( response.status == 422 ){
      alert("You cannot do that.");
      console.log("422 error");
    }

    else {
      console.log("general error");
      wanna_see = confirm('An Error Occurred: ' + response.statusText)
      if ( wanna_see) {
        alert(response.responseText);
      }
    }
  },

  getTimer: function(){
    return 3000;
  }
}
;
Avatar = {
  load: function(plates) {
    plates.each(function(){
      var target = $(this).find('span.owner');
      var id = $(this).attr('plate_id');
      Avatar.get(id,target);
    })
  },

remove: function(plates){
  plates.each(function(){
    var target = $(this).find('span.owner');
    var code = $(this).find('input').val();
    target.css('background-image', '')
    target.css('background-size', '')
    target.fadeOut('fast')
  })
},

get: function(id, target){
  var jqxhr = $.ajax({
      type: "get",
      url: '/spoils/avatar/'+ id
      })
      .success(function(response){
        target.css('background-image', 'url('+ response + ')')
        target.css('background-size', '36px')
        target.css('background-color', '#fff')
        target.css('display', 'block')
        target.css('border', 'thin solid #ccc')
        target.fadeIn('slow', 1)
      })
      .error(function(response){
        Tectonic.handleError(response);
      })
  },

  preload: function(plates) {
    plates.each(function(){
      var target = $(this).find('span.owner');
      var code = $(this).attr('plate_code');

      target.css('background-image', 'url(/img/preloader.gif)')
      target.css('background-color', '')
      target.css('background-size', '36px')
      target.css('border', 'none')
      target.css('opacity', '.8')
      target.css('display', 'block')
      target.fadeIn('slow', 1)
    })
  },

  preUnload: function(plates) {
    plates.each(function(){
      var target = $(this).find('span.owner');
      var code = $(this).attr('plate_code');

      target.css('background-image', 'none')

    })
  }
}
;

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
;
Plate = {
  disable: function(cb){
    console.log("Disable Plate", cb);
    cb.addClass('processing');
    Avatar.preload(cb);
  },

  enable: function(cb, image){
    cb.removeClass('processing');
    if (image !== '') {
      console.log("its a bonus");
      $('#celebration').addClass(image)
      $('#celebration').addClass('fireworks')
    }
    else{
      console.log('not a bonus');
    }
  },

  turnOn: function(cb){
    cb.fadeTo('slow', 1);
    cb.removeClass('visibilty-faded');
    cb.removeClass('found');
    Avatar.remove(cb);
  },

  turnOff: function(cb){
    cb.fadeTo('slow', .3);
    cb.addClass('found');
    cb.addClass('visibilty-faded');
    Avatar.load(cb);
  }
}
;
$(document).ready(function(){

  if ( $("#play").length > 0 ){
    Avatar.load( $('.plate.found') )

    $(document).on('click', '.player-image', function(){
      console.log('selecting player ' +  $(this).closest('.select-player').attr('player_id'));
      if ( $(this).closest('.select-player').hasClass('active-player') ) {
        $(this).closest('.select-player').removeClass('active-player')
      }
      else {
        $('.active-player').removeClass('active-player')
        $(this).closest('.select-player').addClass('active-player')
      }
    });

    $('.plate').on('click', function(){
      var plate = $(this).attr('plate_code');
      var plate_id = $(this).attr('plate_id');

      if( $(this).hasClass('found') ) {
        delete_spoil(plate, $(this))
      }
      else{
        lock(plate, $(this));
        update(plate, plate_id, $(this) )
      }
    })


    function update(plate, plate_id, cb){
      Plate.disable(cb);
      var options = {
        enableHighAccuracy: true,
        timeout: 5000
      };

      navigator.geolocation.getCurrentPosition(
        function(position) {
          var pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          }
          coord_as_string =  position.coords.latitude + "|" + position.coords.longitude
          post_update(plate, plate_id, cb, coord_as_string)
        },
        function(response){},
        options
      )
    }

    function lock(plate, cb){
      var jqxhr = $.ajax({
        type: "POST",
        url: '/spoils/lock',
        dataType: 'JSON',
        data: {
          code: plate
          }
        })
        .success(function(response){})
        .error(function(response){
          Tectonic.handleError(response);
          cb.find('span.owner').fadeOut();
          cb.css('border', 'none');
        })
      }

    function post_update(plate, plate_id, cb, coords){
      var url = '/spoils/'
      console.log($('.active-player'), $('.active-player').attr('player_id'));
      if ( $('.active-player').length ) {
          url = '/spoils/' + $('.active-player').attr('player_id')
      }

      var jqxhr = $.ajax({
        type: "POST",
        url: url,
        dataType: 'JSON',
        data: {
          code: plate,
          plate_id: plate_id,
          current_location: coords
          }
        })
        .success(function(response){
          Plate.enable(cb);
          Plate.turnOff(cb);
        })
        .error(function(response){
          Plate.enable(cb);
          Plate.turnOn(cb);
          Tectonic.handleError(response);
        })
      }

    function delete_spoil(plate, cb){
      console.log('remove spoil?');
      if (confirm("Are you sure you wan to remove this amazing spoil?")){
        var jqxhr = $.ajax({
          type: "POST",
          url: '/spoils/clear',
          dataType: 'JSON',
          data: { code: plate }
          })
          .success(function(response){
            Plate.turnOn(cb)
          })
          .error(function(response){
            Tectonic.handleError(response);
            Plate.turnOff(cb)
          })
      }

      else{
        console.log('false alarm');
      }
    }

    function getLocation(){
      navigator.geolocation.getCurrentPosition( function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        }
        return position.coords.latitude + "::" + position.coords.longitude
      }
    )};
    }


    // media query event handler
  if (matchMedia) {
    //The same value of $small-range
    var mq = window.matchMedia("(min-width: 640px)");
    mq.addListener(WidthChange);
    WidthChange(mq);
  }

// media query change
function WidthChange(mq) {
  var w = $('#players').width();
  console.log(w);
  if (mq.matches) {

    if( $(document.body).hasClass('f-topbar-fixed') ) {
      //console.log('1');
    }
    else {
      //console.log('opriginal load');
    }
    w = $('#players').width();
    $( window ).scroll(function() {
      if($(document.body).hasClass('f-topbar-fixed')) {
        console.log(w);
        $('#players').css('position', 'fixed')
        $('#players').css('top', '60px')
        $('#players').css('width', w + 20)
      }
      else {

        if( !$(document.body).hasClass('f-topbar-fixed') ) {
          console.log('remove fixed');
          $('#players').css('position', 'relative')
          $('#players').css('top', '')
          $('#players').removeClass('fixed-width')
        }
      }
    });
  }
else {
  $( window ).scroll(function() {
      //console.log(5);
    }
  );
  }
}

var mq = window.matchMedia( "(max-width: 640px)" );

if (mq.matches){
  $('#players').addClass('sticky')
}

})
;
(function() {
  var slice = [].slice;

  this.ActionCable = {
    INTERNAL: {
      "message_types": {
        "welcome": "welcome",
        "ping": "ping",
        "confirmation": "confirm_subscription",
        "rejection": "reject_subscription"
      },
      "default_mount_path": "/cable",
      "protocols": ["actioncable-v1-json", "actioncable-unsupported"]
    },
    createConsumer: function(url) {
      var ref;
      if (url == null) {
        url = (ref = this.getConfig("url")) != null ? ref : this.INTERNAL.default_mount_path;
      }
      return new ActionCable.Consumer(this.createWebSocketURL(url));
    },
    getConfig: function(name) {
      var element;
      element = document.head.querySelector("meta[name='action-cable-" + name + "']");
      return element != null ? element.getAttribute("content") : void 0;
    },
    createWebSocketURL: function(url) {
      var a;
      if (url && !/^wss?:/i.test(url)) {
        a = document.createElement("a");
        a.href = url;
        a.href = a.href;
        a.protocol = a.protocol.replace("http", "ws");
        return a.href;
      } else {
        return url;
      }
    },
    startDebugging: function() {
      return this.debugging = true;
    },
    stopDebugging: function() {
      return this.debugging = null;
    },
    log: function() {
      var messages;
      messages = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      if (this.debugging) {
        messages.push(Date.now());
        return console.log.apply(console, ["[ActionCable]"].concat(slice.call(messages)));
      }
    }
  };

  if (typeof window !== "undefined" && window !== null) {
    window.ActionCable = this.ActionCable;
  }

  if (typeof module !== "undefined" && module !== null) {
    module.exports = this.ActionCable;
  }

}).call(this);
(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ActionCable.ConnectionMonitor = (function() {
    var clamp, now, secondsSince;

    ConnectionMonitor.pollInterval = {
      min: 3,
      max: 30
    };

    ConnectionMonitor.staleThreshold = 6;

    function ConnectionMonitor(connection) {
      this.connection = connection;
      this.visibilityDidChange = bind(this.visibilityDidChange, this);
      this.reconnectAttempts = 0;
    }

    ConnectionMonitor.prototype.start = function() {
      if (!this.isRunning()) {
        this.startedAt = now();
        delete this.stoppedAt;
        this.startPolling();
        document.addEventListener("visibilitychange", this.visibilityDidChange);
        return ActionCable.log("ConnectionMonitor started. pollInterval = " + (this.getPollInterval()) + " ms");
      }
    };

    ConnectionMonitor.prototype.stop = function() {
      if (this.isRunning()) {
        this.stoppedAt = now();
        this.stopPolling();
        document.removeEventListener("visibilitychange", this.visibilityDidChange);
        return ActionCable.log("ConnectionMonitor stopped");
      }
    };

    ConnectionMonitor.prototype.isRunning = function() {
      return (this.startedAt != null) && (this.stoppedAt == null);
    };

    ConnectionMonitor.prototype.recordPing = function() {
      return this.pingedAt = now();
    };

    ConnectionMonitor.prototype.recordConnect = function() {
      this.reconnectAttempts = 0;
      this.recordPing();
      delete this.disconnectedAt;
      return ActionCable.log("ConnectionMonitor recorded connect");
    };

    ConnectionMonitor.prototype.recordDisconnect = function() {
      this.disconnectedAt = now();
      return ActionCable.log("ConnectionMonitor recorded disconnect");
    };

    ConnectionMonitor.prototype.startPolling = function() {
      this.stopPolling();
      return this.poll();
    };

    ConnectionMonitor.prototype.stopPolling = function() {
      return clearTimeout(this.pollTimeout);
    };

    ConnectionMonitor.prototype.poll = function() {
      return this.pollTimeout = setTimeout((function(_this) {
        return function() {
          _this.reconnectIfStale();
          return _this.poll();
        };
      })(this), this.getPollInterval());
    };

    ConnectionMonitor.prototype.getPollInterval = function() {
      var interval, max, min, ref;
      ref = this.constructor.pollInterval, min = ref.min, max = ref.max;
      interval = 5 * Math.log(this.reconnectAttempts + 1);
      return Math.round(clamp(interval, min, max) * 1000);
    };

    ConnectionMonitor.prototype.reconnectIfStale = function() {
      if (this.connectionIsStale()) {
        ActionCable.log("ConnectionMonitor detected stale connection. reconnectAttempts = " + this.reconnectAttempts + ", pollInterval = " + (this.getPollInterval()) + " ms, time disconnected = " + (secondsSince(this.disconnectedAt)) + " s, stale threshold = " + this.constructor.staleThreshold + " s");
        this.reconnectAttempts++;
        if (this.disconnectedRecently()) {
          return ActionCable.log("ConnectionMonitor skipping reopening recent disconnect");
        } else {
          ActionCable.log("ConnectionMonitor reopening");
          return this.connection.reopen();
        }
      }
    };

    ConnectionMonitor.prototype.connectionIsStale = function() {
      var ref;
      return secondsSince((ref = this.pingedAt) != null ? ref : this.startedAt) > this.constructor.staleThreshold;
    };

    ConnectionMonitor.prototype.disconnectedRecently = function() {
      return this.disconnectedAt && secondsSince(this.disconnectedAt) < this.constructor.staleThreshold;
    };

    ConnectionMonitor.prototype.visibilityDidChange = function() {
      if (document.visibilityState === "visible") {
        return setTimeout((function(_this) {
          return function() {
            if (_this.connectionIsStale() || !_this.connection.isOpen()) {
              ActionCable.log("ConnectionMonitor reopening stale connection on visibilitychange. visbilityState = " + document.visibilityState);
              return _this.connection.reopen();
            }
          };
        })(this), 200);
      }
    };

    now = function() {
      return new Date().getTime();
    };

    secondsSince = function(time) {
      return (now() - time) / 1000;
    };

    clamp = function(number, min, max) {
      return Math.max(min, Math.min(max, number));
    };

    return ConnectionMonitor;

  })();

}).call(this);
(function() {
  var i, message_types, protocols, ref, supportedProtocols, unsupportedProtocol,
    slice = [].slice,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ref = ActionCable.INTERNAL, message_types = ref.message_types, protocols = ref.protocols;

  supportedProtocols = 2 <= protocols.length ? slice.call(protocols, 0, i = protocols.length - 1) : (i = 0, []), unsupportedProtocol = protocols[i++];

  ActionCable.Connection = (function() {
    Connection.reopenDelay = 500;

    function Connection(consumer) {
      this.consumer = consumer;
      this.open = bind(this.open, this);
      this.subscriptions = this.consumer.subscriptions;
      this.monitor = new ActionCable.ConnectionMonitor(this);
      this.disconnected = true;
    }

    Connection.prototype.send = function(data) {
      if (this.isOpen()) {
        this.webSocket.send(JSON.stringify(data));
        return true;
      } else {
        return false;
      }
    };

    Connection.prototype.open = function() {
      if (this.isActive()) {
        ActionCable.log("Attempted to open WebSocket, but existing socket is " + (this.getState()));
        throw new Error("Existing connection must be closed before opening");
      } else {
        ActionCable.log("Opening WebSocket, current state is " + (this.getState()) + ", subprotocols: " + protocols);
        if (this.webSocket != null) {
          this.uninstallEventHandlers();
        }
        this.webSocket = new WebSocket(this.consumer.url, protocols);
        this.installEventHandlers();
        this.monitor.start();
        return true;
      }
    };

    Connection.prototype.close = function(arg) {
      var allowReconnect, ref1;
      allowReconnect = (arg != null ? arg : {
        allowReconnect: true
      }).allowReconnect;
      if (!allowReconnect) {
        this.monitor.stop();
      }
      if (this.isActive()) {
        return (ref1 = this.webSocket) != null ? ref1.close() : void 0;
      }
    };

    Connection.prototype.reopen = function() {
      var error, error1;
      ActionCable.log("Reopening WebSocket, current state is " + (this.getState()));
      if (this.isActive()) {
        try {
          return this.close();
        } catch (error1) {
          error = error1;
          return ActionCable.log("Failed to reopen WebSocket", error);
        } finally {
          ActionCable.log("Reopening WebSocket in " + this.constructor.reopenDelay + "ms");
          setTimeout(this.open, this.constructor.reopenDelay);
        }
      } else {
        return this.open();
      }
    };

    Connection.prototype.getProtocol = function() {
      var ref1;
      return (ref1 = this.webSocket) != null ? ref1.protocol : void 0;
    };

    Connection.prototype.isOpen = function() {
      return this.isState("open");
    };

    Connection.prototype.isActive = function() {
      return this.isState("open", "connecting");
    };

    Connection.prototype.isProtocolSupported = function() {
      var ref1;
      return ref1 = this.getProtocol(), indexOf.call(supportedProtocols, ref1) >= 0;
    };

    Connection.prototype.isState = function() {
      var ref1, states;
      states = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      return ref1 = this.getState(), indexOf.call(states, ref1) >= 0;
    };

    Connection.prototype.getState = function() {
      var ref1, state, value;
      for (state in WebSocket) {
        value = WebSocket[state];
        if (value === ((ref1 = this.webSocket) != null ? ref1.readyState : void 0)) {
          return state.toLowerCase();
        }
      }
      return null;
    };

    Connection.prototype.installEventHandlers = function() {
      var eventName, handler;
      for (eventName in this.events) {
        handler = this.events[eventName].bind(this);
        this.webSocket["on" + eventName] = handler;
      }
    };

    Connection.prototype.uninstallEventHandlers = function() {
      var eventName;
      for (eventName in this.events) {
        this.webSocket["on" + eventName] = function() {};
      }
    };

    Connection.prototype.events = {
      message: function(event) {
        var identifier, message, ref1, type;
        if (!this.isProtocolSupported()) {
          return;
        }
        ref1 = JSON.parse(event.data), identifier = ref1.identifier, message = ref1.message, type = ref1.type;
        switch (type) {
          case message_types.welcome:
            this.monitor.recordConnect();
            return this.subscriptions.reload();
          case message_types.ping:
            return this.monitor.recordPing();
          case message_types.confirmation:
            return this.subscriptions.notify(identifier, "connected");
          case message_types.rejection:
            return this.subscriptions.reject(identifier);
          default:
            return this.subscriptions.notify(identifier, "received", message);
        }
      },
      open: function() {
        ActionCable.log("WebSocket onopen event, using '" + (this.getProtocol()) + "' subprotocol");
        this.disconnected = false;
        if (!this.isProtocolSupported()) {
          ActionCable.log("Protocol is unsupported. Stopping monitor and disconnecting.");
          return this.close({
            allowReconnect: false
          });
        }
      },
      close: function(event) {
        ActionCable.log("WebSocket onclose event");
        if (this.disconnected) {
          return;
        }
        this.disconnected = true;
        this.monitor.recordDisconnect();
        return this.subscriptions.notifyAll("disconnected", {
          willAttemptReconnect: this.monitor.isRunning()
        });
      },
      error: function() {
        return ActionCable.log("WebSocket onerror event");
      }
    };

    return Connection;

  })();

}).call(this);
(function() {
  var slice = [].slice;

  ActionCable.Subscriptions = (function() {
    function Subscriptions(consumer) {
      this.consumer = consumer;
      this.subscriptions = [];
    }

    Subscriptions.prototype.create = function(channelName, mixin) {
      var channel, params, subscription;
      channel = channelName;
      params = typeof channel === "object" ? channel : {
        channel: channel
      };
      subscription = new ActionCable.Subscription(this.consumer, params, mixin);
      return this.add(subscription);
    };

    Subscriptions.prototype.add = function(subscription) {
      this.subscriptions.push(subscription);
      this.consumer.ensureActiveConnection();
      this.notify(subscription, "initialized");
      this.sendCommand(subscription, "subscribe");
      return subscription;
    };

    Subscriptions.prototype.remove = function(subscription) {
      this.forget(subscription);
      if (!this.findAll(subscription.identifier).length) {
        this.sendCommand(subscription, "unsubscribe");
      }
      return subscription;
    };

    Subscriptions.prototype.reject = function(identifier) {
      var i, len, ref, results, subscription;
      ref = this.findAll(identifier);
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        subscription = ref[i];
        this.forget(subscription);
        this.notify(subscription, "rejected");
        results.push(subscription);
      }
      return results;
    };

    Subscriptions.prototype.forget = function(subscription) {
      var s;
      this.subscriptions = (function() {
        var i, len, ref, results;
        ref = this.subscriptions;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          s = ref[i];
          if (s !== subscription) {
            results.push(s);
          }
        }
        return results;
      }).call(this);
      return subscription;
    };

    Subscriptions.prototype.findAll = function(identifier) {
      var i, len, ref, results, s;
      ref = this.subscriptions;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        s = ref[i];
        if (s.identifier === identifier) {
          results.push(s);
        }
      }
      return results;
    };

    Subscriptions.prototype.reload = function() {
      var i, len, ref, results, subscription;
      ref = this.subscriptions;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        subscription = ref[i];
        results.push(this.sendCommand(subscription, "subscribe"));
      }
      return results;
    };

    Subscriptions.prototype.notifyAll = function() {
      var args, callbackName, i, len, ref, results, subscription;
      callbackName = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
      ref = this.subscriptions;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        subscription = ref[i];
        results.push(this.notify.apply(this, [subscription, callbackName].concat(slice.call(args))));
      }
      return results;
    };

    Subscriptions.prototype.notify = function() {
      var args, callbackName, i, len, results, subscription, subscriptions;
      subscription = arguments[0], callbackName = arguments[1], args = 3 <= arguments.length ? slice.call(arguments, 2) : [];
      if (typeof subscription === "string") {
        subscriptions = this.findAll(subscription);
      } else {
        subscriptions = [subscription];
      }
      results = [];
      for (i = 0, len = subscriptions.length; i < len; i++) {
        subscription = subscriptions[i];
        results.push(typeof subscription[callbackName] === "function" ? subscription[callbackName].apply(subscription, args) : void 0);
      }
      return results;
    };

    Subscriptions.prototype.sendCommand = function(subscription, command) {
      var identifier;
      identifier = subscription.identifier;
      return this.consumer.send({
        command: command,
        identifier: identifier
      });
    };

    return Subscriptions;

  })();

}).call(this);
(function() {
  ActionCable.Subscription = (function() {
    var extend;

    function Subscription(consumer, params, mixin) {
      this.consumer = consumer;
      if (params == null) {
        params = {};
      }
      this.identifier = JSON.stringify(params);
      extend(this, mixin);
    }

    Subscription.prototype.perform = function(action, data) {
      if (data == null) {
        data = {};
      }
      data.action = action;
      return this.send(data);
    };

    Subscription.prototype.send = function(data) {
      return this.consumer.send({
        command: "message",
        identifier: this.identifier,
        data: JSON.stringify(data)
      });
    };

    Subscription.prototype.unsubscribe = function() {
      return this.consumer.subscriptions.remove(this);
    };

    extend = function(object, properties) {
      var key, value;
      if (properties != null) {
        for (key in properties) {
          value = properties[key];
          object[key] = value;
        }
      }
      return object;
    };

    return Subscription;

  })();

}).call(this);
(function() {
  ActionCable.Consumer = (function() {
    function Consumer(url) {
      this.url = url;
      this.subscriptions = new ActionCable.Subscriptions(this);
      this.connection = new ActionCable.Connection(this);
    }

    Consumer.prototype.send = function(data) {
      return this.connection.send(data);
    };

    Consumer.prototype.connect = function() {
      return this.connection.open();
    };

    Consumer.prototype.disconnect = function() {
      return this.connection.close({
        allowReconnect: false
      });
    };

    Consumer.prototype.ensureActiveConnection = function() {
      if (!this.connection.isActive()) {
        return this.connection.open();
      }
    };

    return Consumer;

  })();

}).call(this);
// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//




(function() {
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer();
}).call(this);
/*
  this js file handles the messages being sent to client from WS server
  connected, disconnected, and received are all standard methods this object should implement (there are others)

  #received is the primary method you work with to respond to WS messages
*/


App.game = App.cable.subscriptions.create('GameChannel', {
  connected: function(){
    console.log("Channel connected ::> ", this);
  },
  disconnected: function(){
    console.log("Channel disconnected ::> ", this);
  },
  received: function(data) {
    if (data.message !== undefined){
      MessageBox.set( this.renderMessage(data.message), 'html');
    }

    console.log("cabel data is ", data);

    cb = $("div[plate_code='"+ data.state + "']")

    if (data.action == 'spoil'){
      console.log("bonus?",data.bonus);
      Plate.turnOff(cb);
      Plate.enable(cb, data.image);
      setTimeout(function(){Table.update_points(data.player, data.points)}
        , Tectonic.getTimer());}

    else if (data.action == 'clear'){
      Plate.turnOn(cb);
      Plate.enable(cb);
      setTimeout(function(){
        Table.update_points(data.player, data.points)
        }
        , Tectonic.getTimer());
      }
    else if ( data.action == 'lock') {
      Plate.disable(cb);
      Table.join(data.player)
    }

    else if ( data.action == 'join') {
    }
  },

  renderMessage: function(message) {
    return  message;
  }
});








