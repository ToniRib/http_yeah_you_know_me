require_relative 'html_generator'
require 'pry'
require '../complete_me/lib/complete_me'

class App
  def initialize
    @complete_me = CompleteMe.new
    @html_generator = HtmlGenerator.new
    dictionary = ['pizza']
    @complete_me.populate(dictionary)
  end

  def hello_world(i)
    "Hello, World (#{i})"
  end

  def create_diagnostics(request)
    ["Verb: #{verb(request)}", "Path: #{path(request)}",
      "Protocol: #{protocol(request)}", "Host: #{host(request)}",
      "Port: #{port(request)}", "Origin: #{host(request)}", "#{accept(request)}"].join("\n")
  end

  def generate_response(i, request)
    if verb(request) == 'GET'
      response = get_responses(i, request)
    else
      response = post_responses(i, request)
    end

    @html_generator.generate(response,create_diagnostics(request))
  end

  def post_responses(i, request)
    case path(request)
    when '/start_game'
      "Good luck!"
    end
  end

  def root
    ''
  end

  def shutdown(i)
    "Total Requests: #{i}"
  end

  def get_responses(i, request)
    case path(request)
    when '/'            then root
    when '/hello'       then hello_world(i)
    when '/datetime'    then datetime
    when '/shutdown'    then shutdown(i)
    when '/word_search' then word_response(word(request))
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
