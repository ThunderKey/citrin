require 'citrin'

class Citrin::CLI


  def self.start(*args)
    command = args.shift.strip rescue "help"
    `#{$0}/../../commands/#{command} #{args}`
  end

end
