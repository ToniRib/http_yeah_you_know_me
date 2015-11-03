require 'pry'
require '../complete_me/lib/complete_me'

class App
  def initialize
    @complete_me = CompleteMe.new
    dictionary = ['pizza']
    @complete_me.populate(dictionary)
  end

  def hello_world(i)
    "Hello, World (#{i})"
  end

  def convert_request_to_html(request)
    data = ["Verb: #{verb(request)}", "Path: #{path(request)}",
            "Protocol: #{protocol(request)}", "Host: #{host(request)}",
            "Port: #{port(request)}", "Origin: #{host(request)}", "#{accept(request)}"]
    create_html_string(data)
  end

  def create_html_string(data)
    "<pre>\n#{data.join("\n")}\n</pre>"
  end

  def generate_response(i, request)
    if verb(request) == 'GET'
      get_responses(i, request)
    else
      post_responses(i, request)
    end
  end

  def post_responses(i, request)
    case path(request)
    when '/start_game'
      "Good luck!" + "\n" + convert_request_to_html(request)
    end
  end

  def get_responses(i, request)
    case path(request)
    when '/'
      convert_request_to_html(request)
    when '/hello'
      hello_world(i) + "\n" + convert_request_to_html(request)
    when '/datetime'
      datetime + "\n" + convert_request_to_html(request)
    when '/shutdown'
      "Total Requests: #{i}" + "\n" + convert_request_to_html(request)
    when '/word_search'
      word_response(word(request)) + "\n" + convert_request_to_html(request)
    end
  end

  def datetime
    # 11:07AM on Sunday, November 1, 2015
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y')
  end

  def word_response(word)
    if word?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

  def verb(request)
    request.first.split[0]
  end

  def path(request)
    request.first.split[1].split("?")[0]
  end

  def word(request)
    request.first.split[1].split("?")[1].split("=")[1]
  end

  def word?(word)
    begin
      @complete_me.center.search(word).valid_word
    rescue
      false
    end
  end

  def protocol(request)
    request.first.split[2]
  end

  def host(request)
    request[1].split[1].split(":")[0]
  end

  def port(request)
    request[1].split[1].split(":")[1]
  end

  def accept(request)
    request[4]
  end
end
