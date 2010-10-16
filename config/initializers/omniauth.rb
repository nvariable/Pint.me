Rails.application.config.middleware.use OmniAuth::Builder do
  internal_provider= Provider.instance
  provider :twitter, internal_provider.configs['twitter']['consumer_key'], internal_provider.configs['twitter']['consumer_secret']
  provider :facebook, internal_provider.configs['facebook']['app_id'], internal_provider.configs['facebook']['app_secret']
end