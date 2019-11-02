class ContentfulModel::Configuration
  attr_accessor :logger
end

ContentfulModel.configure do |config|
  config.access_token = Rails.application.secrets.contentful_access_token
  config.preview_access_token = Rails.application.secrets.contentful_preview_token
  config.space = Rails.application.secrets.contentful_space
  config.default_locale = "en-US"
  config.logger = Rails.logger
end
