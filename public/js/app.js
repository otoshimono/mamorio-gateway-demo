window.onload = function(){
  (function(){
    var ws = new WebSocket('ws://' + window.location.host + window.location.pathname);
    ws.onopen = function() {
      console.log('websocket opened');
      $('#websocket-status').text('websocket opened');
    };
    ws.onclose = function() {
      console.log('websocket closed');
      $('#websocket-status').text('websocket closed');
    }
    ws.onmessage = function(m) {
      console.log(m)
    };
  })();
}

