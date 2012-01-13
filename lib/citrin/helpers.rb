module Citrin::Helpers
  def app_root(appname, env)
    env ||= "prod"
    "/var/www/rails_apps/#{env}/#{appname}"
  end

  def url_for(appname, env)
    env ||= "prod"
    if env == "prod"
      "dev.#{appname}.#{`hostname -f`}"
    else
      "#{appname}.#{`hostname -f`}"
    end
  end
  def webserver_config_file(appname, env)
    env ||= "prod"
    "/etc/apache2/sites-enabled/dev.#{appname}.conf"
  end

  def webserver_template_file(env)
    env ||= "prod"
    "/etc/apache2/templates/#{prod}_rails.conf"
  end
end
