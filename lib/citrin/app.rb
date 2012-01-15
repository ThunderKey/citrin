module Citrin
  class App
    def initializei(name, env="prod")
      @name = name
      @env = env
      @env ||= "prod"
    end

    def app_root
      "/var/www/rails_apps/#{@env}/#{@name}"
    end

    def url_for
      if @env == "dev"
        "dev.#{@name}.#{`hostname -f`}"
      elsif @env == "prod"
        "#{@appname}.#{`hostname -f`}"
      else
        raise "Invalid Environment"
      end
    end
    def webserver_config_file
      "/etc/apache2/sites-enabled/#{@env}.#{@name}.conf"
    end

  end
end
