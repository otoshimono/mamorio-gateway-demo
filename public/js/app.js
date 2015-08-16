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
      var data = JSON.parse(m.data);
      var selectedDeviceUUID = $('#device').val();
      if (selectedDeviceUUID.length > 0) {
        if (data['device_uuid'] == selectedDeviceUUID) {
          addRow(data);
        }
      }
      else {
        addRow(data);
      }
    };
  })();
}

var addRow = function(data) {
  var html = '<tr>';
  html = html + '<td>' + data['device_uuid'] + '</td>';
  html = html + '<td>' + data['beacon_proximity_uuid'] + '</td>';
  html = html + '<td>' + data['beacon_major'] + '</td>';
  html = html + '<td>' + data['beacon_minor'] + '</td>';
  html = html + '<td>' + data['beacon_accuracy'] + '</td>';
  html = html + '<td>' + data['beacon_rssi'] + '</td>';
  html = html + '</tr>';
  $('#logs > tbody > tr:first').after(html);
}
