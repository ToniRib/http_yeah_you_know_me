require_relative 'app'
require_relative 'client_handler'

client_handler = ClientHandler.new
app = App.new
i = 0

loop do
  request = client_handler.get_request
  response = app.hello_world(i)
  client_handler.post_response(response)
  i += 1 unless request.first.include?("favicon")
end
