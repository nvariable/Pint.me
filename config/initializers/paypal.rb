class PaymentGateway
  include Singleton

  def configs
    @configs ||= YAML::load(File.new(File.join(Rails.root, 'config', 'paypal.yml')))
  end
end