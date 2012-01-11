require 'citrin'

class Citrin::CLI


  def self.start(*args)
    command = args.shift.strip rescue "help"
    `../../commands/#{command} #{args}`
  end

end
