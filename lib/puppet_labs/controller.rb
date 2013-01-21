module PuppetLabs
class Controller
  attr_reader :request,
    :route,
    :logger

  ##
  # initialize the instance variables for the Controller.  This method should
  # be called from subclasses using super(options)
  #
  # @option options [Rack::Request] :request the request instance
  #
  # @option options [Sinatra::Route] :route the sinatra route instance
  #
  # @option options [Logger] :logger Logger instance for logging
  def initialize(options = {})
    @options = options
    if request = options[:request]
      @request = request
    end
    if route = options[:route]
      @route = route
    end
    if logger = options[:logger]
      @logger = logger
    else
      @logger = Logger.new(STDOUT)
    end
  end
end
end
