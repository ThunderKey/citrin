require 'helper'

class TestCitrin < Test::Unit::TestCase
  should "create webserver config" do
    appname = "citest"
    Citrin::CLI.start("create_webserver", appname)
    assert_true File.exists?("/etc/apache2/sites-enabled/prod.#{appname}.conf")
    statuscode = `curl -sL -w "%{http_code}" "#{appname}.$(hostname).citrin.ch" -o /dev/null`
    assert_equals statuscode, "404"
  end
end
