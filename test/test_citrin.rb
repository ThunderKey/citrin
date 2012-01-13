$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'helper'
require 'citrin/cli'

class TestCitrin < Test::Unit::TestCase

  def setup
    @appname = "citest" 
  end

  def cleanup
    Citrin::CLI.start("remove_railsapp", @appname)
  end

  should "create webserver config" do
    Citrin::CLI.start("create_webserver", @appname)
    assert File.exists?("/etc/apache2/sites-enabled/prod.#{@appname}.conf")
    `cd /var/www/rails_apps/prod/ && rails new #{@appname}`
    statuscode = `curl -sL -w "%{http_code}" "#{@appname}.$(hostname).citrin.ch" -o /dev/null`
    assert_equal "200", statuscode
    cleanup
  end
end
