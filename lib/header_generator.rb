class HeaderGenerator
  def headers(output_length, status_code)
    # if status_code == 'redirect'
      # add location
    # else
      # dont' add a location
      headers = ["http/1.1 #{status_code}",
                 "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                 "server: ruby",
                 "content-type: text/html; charset=iso-8859-1",
                 "content-length: #{output_length}\r\n\r\n"]
      headers << location_line if status_code== "301 Moved Permanently"
     headers.join("\r\n")
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
