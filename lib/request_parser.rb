require 'pry'

class RequestParser
  def verb(request)
    request.first.split[0]
  end

  def path(request)
    request.first.split[1].split("?")[0]
  end

  def word(request)
    if request[0].include?('?')
      request.first.split[1].split("?")[1].split("=")[1]
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
