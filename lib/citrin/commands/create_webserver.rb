module Commands
class CreateWebserver
  def initialize(options = {}
    @options = options
  end
  def self.run
   `cp -p #{@options[:conf_template]} #{@options[:conffile]}` 
    sed_str=`echo #{@options[:app_root} | sed -e 's/\(\/\|\\\|&\)/\\&/g')`

    `sed -i "s/PROJECT_ROOT/#{sed_str}/g" #{@options[:conffile]}`
    `sed -i "s/PROJECT_ROOT/#{@options[:url]}/g" #{@options[:conffile]}`
    
    puts "Apache VirtualHost Konfiguration unter: #{@options[:conffile]}"
    puts "App Root unter: #{@options[:app_root}}"
    puts "URL: http://#{@options[:url]}"

    puts "Apache reload"
    `sudo service apache2 reload 2>&1 > /dev/null`
  end
end
end
