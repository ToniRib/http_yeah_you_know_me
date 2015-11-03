require_relative 'html_generator'
require_relative 'request_parser'
require_relative 'word_search'
require 'pry'

class App
  def initialize
    @html_generator = HtmlGenerator.new
    @parser = RequestParser.new
    @word_search = WordSearch.new
  end

  def generate_response(i, request)
    if @parser.verb(request) == 'GET'
      response = get_responses(i, request)
    else
      response = post_responses(i, request)
    end

    @html_generator.generate(response, @parser.diagnostics(request))
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
    when '/word_search' then @word_search.word_response(@parser.word(request))
    end
  end

  def hello_world(i)
    "Hello, World (#{i})"
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

  def datetime
    # 11:07AM on Sunday, November 1, 2015
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y')
  end
end
