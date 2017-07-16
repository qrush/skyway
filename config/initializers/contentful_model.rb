ContentfulModel.configure do |config|
  config.access_token = ENV["CONTENTFUL_ACCESS_TOKEN"]
  config.preview_access_token = ENV["CONTENTFUL_PREVIEW_TOKEN"]
  # config.management_token = "your management token in here"
  config.space = ENV["CONTENTFUL_SPACE"]
  config.default_locale = "en-US"
end
