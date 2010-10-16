class Provider
  include Singleton
  
  def configs
    @configs ||= YAML::load(File.new(File.join(Rails.root, 'config', 'providers.yml')))
  end
end
