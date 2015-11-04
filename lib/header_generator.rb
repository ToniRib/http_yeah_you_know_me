require 'pry'

class HeaderGenerator
  def headers(output_length, status_code)
    headers = ["http/1.1 #{status_code}",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: #{output_length}\r\n\r\n"]

    headers.insert(3, location_line) if status_code == '301 MOVED PERMANENTLY'

    headers.join("\r\n")
  end

  def location_line
    "location: http://127.0.0.1:9292/game?word=post"
  end
end
