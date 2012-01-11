require 'citrin'

class Citrin::CLI

  def help
    puts %Q{
      Usage: citrin command [args]
      Commands are:
       database create appname
       webserver create appname
       svn create appname
    }
  end

  def self.start(*args)
    command = args.shift.strip rescue "help"
    `../commands/#{command} #{args}`
  end

end
