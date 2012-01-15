module Citrin
  class App
    def initialize(name, env="prod")
      @name = name
      @env = env
      @env ||= "prod"
    end

    def name
      @name
    end

    def env
      @env
    end

    def fullenv
      case(@env)
        when "prod"
          return "production"
        when "dev"
          return "development"
        when "test"
          return "test"
      else
        raise "Invalid Environment"
      end
    end

    def app_root
      "/var/www/rails_apps/#{@env}/#{@name}"
    end

    def url
      if @env == "dev"
        "dev.#{@name}.#{`hostname -f`}"
      elsif @env == "prod"
        "#{@name}.#{`hostname -f`}"
      else
        raise "Invalid Environment"
      end
    end
    def webserver_config_file
      "/etc/apache2/sites-enabled/#{@env}.#{@name}.conf"
    end

    def db_name
      "#{@name}_#{@env}"
    end

    def db_user
      "#{@name}_#{@env}"
    end

    def db_pass
      @db_pass ||=`pwgen -1`.chomp
      @db_pass
    end
  end
end
