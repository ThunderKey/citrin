require 'citrin'

class Citrin::CLI

  def self.start(*args)
    command = args.shift.strip rescue "help"
    puts `#{File.dirname(__FILE__)}/../../commands/#{command} #{args}`
  end

end
