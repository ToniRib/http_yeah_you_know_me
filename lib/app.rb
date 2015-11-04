require_relative 'html_generator'
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

    puts @status_code
    @html_generator.generate(response, @parser.diagnostics)
  end

  def post_responses
    case @parser.path
    when '/start_game'
      # does @game already exist? if yes -> some status code if no-> some other
      @game = Game.new
      @responses.good_luck
    when '/game'
      @game.store_guess(@parser.word.to_i)
      @status_code = '301 MOVED PERMANENTLY'
      ''
      # set our response to be ''
      # set the header to be 301 moved permanently
      # @responses.game(@game.check_guess, @game.number_of_guesses)
    end
  end

  def get_responses(i)
    case @parser.path
    when '/'            then @responses.root
    when '/hello'       then @responses.hello_world(i)
    when '/datetime'    then @responses.datetime
    when '/shutdown'    then @responses.shutdown(i)
    when '/word_search' then @responses.word_search(@parser.word)
    when '/game'        then @responses.game(@parser.word, @game)
    # else                then @status_code = '404 NOT FOUND'
    end
  end

  def generate_headers(length)
    # binding.pry
    @header_generator.headers(length, @status_code)
  end
end
