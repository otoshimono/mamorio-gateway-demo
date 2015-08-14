require 'sinatra'
require 'json'

get '/' do
  slim :index
end

post '/log', provides: :json  do
  params = JSON.parse request.body.read

end
