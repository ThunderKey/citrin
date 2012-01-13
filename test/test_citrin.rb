$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'helper'
require 'citrin/cli'

class TestCitrin < Test::Unit::TestCase
  should "create webserver config" do
    appname = "citest"
    Citrin::CLI.start("create_webserver", appname)
    assert File.exists?("/etc/apache2/sites-enabled/prod.#{appname}.conf")
    statuscode = `curl -sL -w "%{http_code}" "#{appname}.$(hostname).citrin.ch" -o /dev/null`
    assert_equal "404", statuscode
  end
end
