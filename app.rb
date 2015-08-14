require 'sinatra'
require 'sinatra-websocket'
require 'slim'
require 'json'

set :server, 'thin'
set :sockets, []

get '/' do
  if !request.websocket?
    slim :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send("Hello World!")
        settings.sockets << ws
      end
      ws.onclose do
        warn("websocket closed")
        settings.sockets.delete(ws)
      end
    end
  end
end

post '/logs' do
  json = JSON.parse(request.body.read)
  row = {
    device_uuid: json['device_uuid'],
    beacon_rssi: json['beacon']['rssi'],
    beacon_accuracy: json['beacon']['accuracy'],
    beacon_major: json['beacon']['major'],
    beacon_minor: json['beacon']['minor']
  }
  row_string = JSON.generate(row)
  p row_string
  EM.next_tick do
    settings.sockets.each do |s|
      s.send(row_string);
    end
  end
end

