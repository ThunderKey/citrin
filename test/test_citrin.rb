$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'helper'
require 'citrin/cli'
require 'mysql2'

class TestCitrin < Test::Unit::TestCase

  def setup
    @appname = "citest" 
  end

  def cleanup
    Citrin::CLI.start("remove_railsapp", @appname)
    @app = Citrin::App.new(@appname)
    begin
       # connect to the MySQL server
       dbh = Mysql2::Client.new(:host => "localhost", :username => Citrin::config['db_user'], :password => Citrin::config['db_pass'] )
       dbh.query("drop user #{@app.db_user}@localhost;");
       dbh.query("drop database #{@app.db_name};");
    rescue
    ensure
      # disconnect from server
      dbh.close if dbh
    end
  end

  should "create webserver config" do
    Citrin::CLI.start("create_webserver", @appname)
    assert File.exists?("/etc/apache2/sites-enabled/prod.#{@appname}.conf")
    `cd /var/www/rails_apps/prod/ && rails new #{@appname}`
    statuscode = `curl -sL -w "%{http_code}" "#{@appname}.$(hostname -f)" -o /dev/null`
    assert_equal "200", statuscode
  end

  should "create database" do
   @app=Citrin::CLI.start("create_database", @appname)
   begin
     # connect to the MySQL server
     dbh = Mysql2::Client.new(:host => "localhost", :username => @app.db_user, :password => @app.db_pass, :database => @app.db_name )
   rescue Mysql2::Error => e
     puts "Error message: #{e.error}"
     fail "Can't connect to created DB"
   ensure
     # disconnect from server
     dbh.close if dbh
   end
   cleanup
  end
end
