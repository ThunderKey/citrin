require 'erb'
module Commands
  class CreateWebserver
    extend Citrin::Helpers
    def self.run(app)
      @app = app
      template_file = webserver_template_file(@app.env)
      template = ERB.new(File.read(template_file), 0, "%<>")
      result = template.result(binding)
      File.open(@app.webserver_config_file, 'w') {|f| f.write(result ) }
    
      puts "Apache VirtualHost Konfiguration unter: #{@app.webserver_config_file}"
      puts "App Root unter: #{@app.app_root}"
      puts "URL: http://#{@app.url}"

      puts "Apache reload"
      `sudo service apache2 reload 2>&1 > /dev/null`
    end
  end
end
