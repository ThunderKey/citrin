require 'erb'
module Commands
  class CreateDatabase
    extend Citrin::Helpers
    def self.run(app)
      @app = app
      db_name="#{@app.name}_#{@app.env}"
      db_user="#{@app.name}_#{@app.env}"
      db_user_pw=`pwgen -1`
      db_queries %Q{
        create database #{db_name};
        GRANT ALL ON #{db_user}.* TO '#{db_name}'@'localhost';
        SET PASSWORD FOR '#{db_user}'@'localhost' = PASSWORD('#{db_user_pw}');
      }
      `mysql --user #{Citrin::config[:db_user]} --password=#{Citrin::config[:db_pass]} -e #{db_queries}`

      template_file = database_template_file(@app.env)
      template = ERB.new(File.read(template_file), 0, "%<>")
      result = template.result(binding)

      puts "Put this in your config/database.yml"
      puts result
      
      puts "and run"
      puts "  RAILS_ENV=#{@app.fullenv} rake db:migrate"
    
    end
  end
end
