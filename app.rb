require 'rack'
require 'rack/response'

class App

  def call(env)
    @request = Rack::Request.new(env)
    @params = @request.params
    if request_valid?
      time_response
    else
      http_response(404, 'Not found!')
    end
  end

  private

  def request_valid?
    @request.path_info == '/time' && @params['format']
  end

  def time_response
    time_format = TimeFormat.new(@params)

    if time_format.valid?
      http_response(200, time_format.result)
    else
      http_response(400, "Unknown time format [#{time_format.invalid.join('-')}]")
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def http_response(status, body)
    Rack::Response.new(body, status, headers).finish
  end

end

