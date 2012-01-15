require 'erb'
module Commands
  class CreateDatabase
    extend Citrin::Helpers
    def self.run(app)
      @app = app
      db_queries = %Q{
        create database #{@app.db_name};
        GRANT ALL ON #{@app.db_user}.* TO '#{@app.db_name}'@'localhost';
        SET PASSWORD FOR '#{@app.db_user}'@'localhost' = PASSWORD('#{@app.db_pass}');
      }
      `mysql --user=#{Citrin::config['db_user']} --password=#{Citrin::config['db_pass']} -e "#{db_queries}"`

      template_file = database_template_file(@app.env)
      template = ERB.new(File.read(template_file), 0, "%<>")
      result = template.result(binding)

      puts %Q{
Put this in your config/database.yml
#{result}

and run
  RAILS_ENV=#{@app.fullenv} rake db:migrate"
      }
      return @app    
    end
  end
end
