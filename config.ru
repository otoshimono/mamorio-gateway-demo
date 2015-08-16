#config.ru
require './app'
require "sinatra/twitter-bootstrap"

run Sinatra::Application
