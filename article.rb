require 'sinatra'
require 'sinatra-websocket'
require 'json'

get '/' do
  if !request.websocket?
    slim :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send("Hello World!")
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
      end
      ws.onclose do
        warn("websocket closed")
        settings.sockets.delete(ws)
      end
    end
  end
end

post '/log', provides: :json  do
  params = JSON.parse request.body.read

end
