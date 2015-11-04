require 'pry'

class RequestParser
  attr_reader :request

  def initialize(raw_request)
    @request = {}
    build_hash(raw_request)
  end

  def build_hash(raw_request)
    parse_first_line(raw_request.shift)
    parse_host(raw_request.shift)
    parse_body(raw_request.pop(3)) if raw_request.length > 9
    parse_headers(raw_request)
  end

  def parse_first_line(line)
    @request['Verb'] = line.split[0]
    @request['Path'] = line.split[1].split("?")[0]
    @request['Word'] = line.split[1].split("?")[1].split("=")[1] if line.include?('?')
    @request['Protocol'] = line.split[2]
  end

  def parse_host(line)
    @request['Host'] = line.split[1].split(":")[0]
    @request['Port'] = line.split[1].split(":")[1]
  end

  def parse_body(body)
    @request['Guess'] = body.last.chomp.to_i
  end

  def parse_headers(array)
    array.each do |line|
      split_line = line.split
      @request[split_line[0].chop] = split_line[1]
    end
  end

  def verb
    request['Verb']
  end

  def path
    request['Path']
  end

  def guess
    request['Guess']
  end

  def word
    request['Word']
  end

  def protocol
    request['Protocol']
  end

  def host
    request['Host']
  end

  def port
    request['Port']
  end

  def accept
    request['Accept']
  end

  def diagnostics
    ["Verb: #{verb}", "Path: #{path}",
     "Protocol: #{protocol}", "Host: #{host}",
     "Port: #{port}", "Origin: #{host}",
     "Accept: #{accept}"].join("\n")
  end
end
