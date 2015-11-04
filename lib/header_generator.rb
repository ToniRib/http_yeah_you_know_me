class HeaderGenerator
  def headers(output_length, path, verb)
    combinations = valid_path_verb_combo

    if combinations[verb].include?(path)
      headers = ["http/1.1 200 OK",
                 "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                 "server: ruby",
                 "content-type: text/html; charset=iso-8859-1",
                 "content-length: #{output_length}\r\n\r\n"].join("\r\n")
    else
      # do more stuff here
    end

     headers
  end

  def valid_path_verb_combo
    { 'GET'  => ['/', '/hello', '/datetime', '/word_search', '/shutdown', '/game'],
      'POST' => ['/game', '/start_game'] }
  end
end

# header for redirect to game per correct iteration 4
# def headers(output_length)
#   ["http/1.1 302 FOUND",
#     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#     "server: ruby",
#     "location: http://127.0.0.1:9292/game",
#     "content-type: text/html; charset=iso-8859-1",
#     "content-length: #{output_length}\r\n\r\n"].join("\r\n")
# end
