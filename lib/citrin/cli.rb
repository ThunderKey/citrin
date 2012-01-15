require 'citrin'
require 'citrin/helpers'
require 'citrin/app'
require 'citrin/commands'

class Citrin::CLI
  extend Citrin::Helpers

  def self.start(*args)
    command = args.shift.strip rescue "help"
    Citrin::Commands.load
    name = args[0]
    env = args[1]
    app = Citrin::App.new(name, env)
    case command
    when "create_svn_rails"
      puts `#{File.dirname(__FILE__)}/../../commands/create_svn #{args.join(" ")} --with-rails`
    when "create_database"
      return Commands::CreateDatabase.run(app)
    when "create_webserver"
      return Commands::CreateWebserver.run(app)
    when "write_config"
      `cp #{File.dirname(__FILE__)}/../../etc/citrin.yml /etc/citrin.yml`
    else
      begin
        puts `#{File.dirname(__FILE__)}/../../commands/#{command} #{args.join(" ")}`
      rescue
        help
      end
    end
  end

  def self.help
    puts `#{File.dirname(__FILE__)}/../../commands/help`
  end

end
