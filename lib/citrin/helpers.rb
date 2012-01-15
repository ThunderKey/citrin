module Citrin::Helpers

  def webserver_template_file(env)
    env ||= "prod"
    File.dirname(__FILE__)+"../templates/#{env}_virtualhost.erb"
  end
end
