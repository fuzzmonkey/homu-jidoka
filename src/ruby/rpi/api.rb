require 'sinatra'
require 'json'

post '/sensors/:id' do |node_id|
  json_payload = JSON.parse( request.body.read )

  puts "Node: #{node_id} Received: #{json_payload}"

  ""
end