require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'request_parser'
require_relative 'word_search'
require_relative 'responses'
require_relative 'game'
require 'pry'

class App
  def initialize
    @html_generator = HtmlGenerator.new
    @responses = Responses.new
    @header_generator = HeaderGenerator.new
  end

  def generate_response(i, request)
    @status_code = '200 OK'
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
      if @game
        @status_code = '403 FORBIDDEN'
        @responses.game_in_progress
      else
        @game = Game.new
        @status_code = '301 MOVED PERMANENTLY'
        @responses.good_luck
      end
    when '/game'
      @game.store_guess(@parser.guess)
      @status_code = '301 MOVED PERMANENTLY'
      @responses.root
    end
  end

  def get_responses(i)
    case @parser.path
    when '/'            then @responses.root
    when '/hello'       then @responses.hello_world(i)
    when '/datetime'    then @responses.datetime
    when '/shutdown'    then @responses.shutdown(i)
    when '/word_search'
      if @parser.accept.start_with?('application/json')
        @responses.word_suggest(@parser.word)
      else
        @responses.word_search(@parser.word)
      end
    when '/game'        then @responses.game(@parser.word, @game)
    when '/force_error'
      @status_code = '500 INTERNAL SERVER ERROR'
      @responses.system_error
    else                     @status_code = '404 NOT FOUND'
    end
  end

  def generate_headers(length)
    @header_generator.headers(length, @status_code)
  end
end
