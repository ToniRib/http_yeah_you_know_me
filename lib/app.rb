require_relative 'html_generator'
require_relative 'request_parser'
require 'pry'
require '../complete_me/lib/complete_me'

class App
  def initialize
    @complete_me = CompleteMe.new
    @html_generator = HtmlGenerator.new
    @parser = RequestParser.new
    dictionary = ['pizza']
    @complete_me.populate(dictionary)
  end

  def hello_world(i)
    "Hello, World (#{i})"
  end

  def create_diagnostics(request)
    ["Verb: #{@parser.verb(request)}", "Path: #{@parser.path(request)}",
      "Protocol: #{@parser.protocol(request)}", "Host: #{@parser.host(request)}",
      "Port: #{@parser.port(request)}", "Origin: #{@parser.host(request)}", "#{@parser.accept(request)}"].join("\n")
  end

  def generate_response(i, request)
    if @parser.verb(request) == 'GET'
      response = get_responses(i, request)
    else
      response = post_responses(i, request)
    end

    @html_generator.generate(response,create_diagnostics(request))
  end

  def good_luck
    "Good luck!"
  end

  def root
    ''
  end

  def shutdown(i)
    "Total Requests: #{i}"
  end

  def post_responses(i, request)
    case @parser.path(request)
    when '/start_game' then good_luck
    end
  end

  def get_responses(i, request)
    case @parser.path(request)
    when '/'            then root
    when '/hello'       then hello_world(i)
    when '/datetime'    then datetime
    when '/shutdown'    then shutdown(i)
    when '/word_search' then word_response(@parser.word(request))
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

  def word?(word)
    begin
      @complete_me.center.search(word).valid_word
    rescue
      false
    end
  end
end
