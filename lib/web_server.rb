require_relative 'app'
require_relative 'client_handler'

client_handler = ClientHandler.new
app = App.new
i = 0

loop do
  request = client_handler.get_request
  response = app.generate_response(i, request)
  client_handler.post_response(response)

  if !response.nil? && response.include?("Total Requests:")
    break
  end

  i += 1 unless request.first.include?("favicon")
end

puts "Shutting down"
