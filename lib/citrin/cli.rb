require 'citrin'

class Citrin::CLI

  def self.start(*args)
    command = args.shift.strip rescue "help"
    `#{File.dirname(__FILE__)}/../../commands/#{command} #{args}`
  end

end
