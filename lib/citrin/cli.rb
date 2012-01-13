require 'citrin'
require 'citrin/helpers'

class Citrin::CLI
  extend Citrin::Helpers

  def self.start(*args)
    command = args.shift.strip rescue "help"
    case command
    when "create_svn_rails"
      puts `#{File.dirname(__FILE__)}/../../commands/create_svn #{args.join(" ")} --with-rails`
    when "create_webserver"
      name = args[0]
      env = args[1]
      args = [
        name,
        webserver_template_file(env),
        webserver_config_file(name, env),
        url_for(name, env)
      ]
      puts `#{File.dirname(__FILE__)}/../../commands/create_webserver #{args.join(" ")}`
    else
      puts `#{File.dirname(__FILE__)}/../../commands/#{command} #{args.join(" ")}`
    end
  end

end
