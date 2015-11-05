require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'request_parser'
require_relative 'responses'
require_relative 'game'

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
    when '/start_game' then start_or_refuse_new_game
    when '/game'       then check_for_current_game
    end
  end

  def check_for_current_game
    if @game
      store_guess_and_redirect
    else
      no_game_started
    end
  end

  def start_or_refuse_new_game
    if @game
      refuse_new_game_start
    else
      start_new_game_and_redirect
    end
  end

  def store_guess_and_redirect
    @game.store_guess(@parser.guess)
    @status_code = '301 MOVED PERMANENTLY'
    @responses.root
  end

  def refuse_new_game_start
    @status_code = '403 FORBIDDEN'
    @responses.game_in_progress
  end

  def no_game_started
    @status_code = '403 FORBIDDEN'
    @responses.no_game_started
  end

  def start_new_game_and_redirect
    @game = Game.new
    @status_code = '301 MOVED PERMANENTLY'
    @responses.good_luck
  end

  def get_responses(i)
    case @parser.path
    when '/'            then @responses.root
    when '/hello'       then @responses.hello_world(i)
    when '/datetime'    then @responses.datetime
    when '/shutdown'    then @responses.shutdown(i)
    when '/word_search' then check_for_json_request
    when '/game'        then get_game_status_for_current_game
    when '/force_error' then force_error_status_and_response
    else                     @status_code = '404 NOT FOUND'
    end
  end

  def get_game_status_for_current_game
    if @game
      @responses.game(@parser.word, @game)
    else
      no_game_started
    end
  end

  def check_for_json_request
    if @parser.accept.start_with?('application/json')
      @responses.word_suggest(@parser.word)
    else
      @responses.word_search(@parser.word)
    end
  end

  def force_error_status_and_response
    @status_code = '500 INTERNAL SERVER ERROR'
    @responses.system_error
  end

  def generate_headers(length)
    @header_generator.headers(length, @status_code)
  end
end
