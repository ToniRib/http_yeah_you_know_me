require_relative 'html_generator'
require_relative 'request_parser'
require_relative 'word_search'
require_relative 'responses'
require 'pry'

class App
  def initialize
    @html_generator = HtmlGenerator.new
    @responses = Responses.new
  end

  def generate_response(i, request)
    @parser = RequestParser.new(request)
    if @parser.verb == 'GET'
      response = get_responses(i)
    else
      response = post_responses
    end

    @html_generator.generate(response, @parser.diagnostics)
  end

  def post_responses
    case @parser.path
    when '/start_game'
      @responses.good_luck
      #start game
    when '/game'
      # check guess
      # output response
    end
  end

  def get_responses(i)
    case @parser.path
    when '/'            then @responses.root
    when '/hello'       then @responses.hello_world(i)
    when '/datetime'    then @responses.datetime
    when '/shutdown'    then @responses.shutdown(i)
    when '/word_search' then @responses.word_search(@parser.word)
    end
  end
end
