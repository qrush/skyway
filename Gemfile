ruby '2.3.1'
source 'https://rubygems.org'

gem 'rails', '~> 5.0'
gem 'spring', group: 'development'
gem 'pg'

gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'uglifier'

gem 'bourbon', '~> 4.0.2'
gem 'bitters', '~> 0.9.3'
gem 'neat', '~> 1.6.0'

gem 'dynamic_form'
gem 'jbuilder'
gem 'rack-rewrite'
gem 'chronic'

gem 'paperclip'
gem 'aws-sdk'
gem 'high_voltage'
gem 'kramdown'
gem 'simple_mercator_location'
gem 'geocoder'
gem 'musicbrainz', require: false

gem 'omniauth'
gem 'omniauth-auth0'

group :production, :staging do
  # Bumping some unicorn deps so the app builds on 2.2.0
  gem 'unicorn'
  gem 'kgio', '~> 2.9.3'
  gem 'raindrops', '~> 0.13.0'

  gem 'rails_12factor'
  gem 'memcachier'
  gem 'dalli'

  gem 'bugsnag'
end

group :test do
  gem 'capybara'
  gem 'launchy'
end
