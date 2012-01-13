module Citrin::Helpers
  def app_root(appname, env)
    env ||= "prod"
    "/var/www/rails_apps/#{env}/#{appname}"
  end

  def url_for(appname, env)
    env ||= "prod"
    if env == "dev"
      "dev.#{appname}.#{`hostname -f`}"
    elsif env == "prod"
      "#{appname}.#{`hostname -f`}"
    else
      raise "Invalid Environment"
    end
  end
  def webserver_config_file(appname, env)
    env ||= "prod"
    "/etc/apache2/sites-enabled/#{env}.#{appname}.conf"
  end

  def webserver_template_file(env)
    env ||= "prod"
    "/etc/apache2/templates/#{env}_rails.conf"
  end
end
