require 'citrin'
require 'citrin/helpers'
require 'citrin/app'
require 'citrin/commands'

class Citrin::CLI
  extend Citrin::Helpers

  def self.start(*args)
    command = args.shift.strip rescue "help"
    Citrin::Commands.load
    case command
    when "create_svn_rails"
      puts `#{File.dirname(__FILE__)}/../../commands/create_svn #{args.join(" ")} --with-rails`
    when "create_webserver"
      name = args[0]
      env = args[1]
      c = CreateWebserver.new(App.new(name, env))
      c.run
    else
      puts `#{File.dirname(__FILE__)}/../../commands/#{command} #{args.join(" ")}`
    end
  end

end
