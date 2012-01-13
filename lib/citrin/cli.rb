require 'citrin'
require 'citrin/helpers'
require 'citrin/commands'

class Citrin::CLI
  extend Citrin::Helpers

  def self.start(*args)
    command = args.shift.strip rescue "help"
    case command
    when "create_svn_rails"
      puts `#{File.dirname(__FILE__)}/../../commands/create_svn #{args.join(" ")} --with-rails`
    when "create_webserver"
      Citrin::Commands.load
      name = args[0]
      env = args[1]
      c = CreateWebserver.new({
        :conf_template => webserver_template_file(env),
        :conffile => webserver_config_file(name, env),
        :url => url_for(name, env),
        :app_root => app_root(name, env)
      })
      c.run
    else
      puts `#{File.dirname(__FILE__)}/../../commands/#{command} #{args.join(" ")}`
    end
  end

end
