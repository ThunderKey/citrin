require 'citrin'

class Citrin::CLI

  def self.start(*args)
    command = args.shift.strip rescue "help"
    if command == "create_svn_rails"
      puts `#{File.dirname(__FILE__)}/../../commands/create_svn #{args.join(" ")} --with-rails`
    else
      puts `#{File.dirname(__FILE__)}/../../commands/#{command} #{args.join(" ")}`
    end
  end

end
