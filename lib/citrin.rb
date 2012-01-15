require 'yaml'
module Citrin

  def self.config
    refs = open('/etc/citrin.yml') {|f| YAML.load(f) }
    return refs["citrin"]
  end
end
