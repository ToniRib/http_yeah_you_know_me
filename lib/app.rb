require_relative 'html_generator'
require_relative 'request_parser'
require_relative 'word_search'
require_relative 'responses'
require 'pry'

class App
  def initialize
    @html_generator = HtmlGenerator.new
    @parser = RequestParser.new
    @word_search = WordSearch.new
    @responses = Responses.new
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
    when '/start_game' then @responses.good_luck
    end
  end

  def get_responses(i, request)
    case @parser.path(request)
    when '/'            then @responses.root
    when '/hello'       then @responses.hello_world(i)
    when '/datetime'    then @responses.datetime
    when '/shutdown'    then @responses.shutdown(i)
    when '/word_search' then @responses.word_search(@parser.word(request))
    end
  end
end
