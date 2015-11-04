require_relative 'app'
require_relative 'client_handler'
require_relative 'header_generator'

client_handler = ClientHandler.new
app = App.new
i = 0

loop do
  request = client_handler.get_request

  unless request.first.include?('favicon')
    response = app.generate_response(i, request)
    headers = app.generate_headers(response.length)

    client_handler.post_response(headers, response)

    break if !response.nil? && response.include?('Total Requests:')

    i += 1
  end
end

puts 'Shutting down'
