require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
          {'Content-Type' => 'text/html'}, []]
      end
      if env['PATH_INFO'] == '/'
        return [301, {'Content-Type' => 'text/html', 'Location' => 'http://localhost:3001/quotes/a_quote'}, []]
      end
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type' => 'text/html'},
      [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end
    def env
      @env
    end
  end
end
