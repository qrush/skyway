ruby '2.2.0'
source 'https://rubygems.org'

gem 'rails', '~> 4.1'
gem 'spring', group: 'development'
gem 'pg'

gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'uglifier'

gem 'bourbon'
gem 'bitters'
#gem 'refills'
gem 'neat'

gem 'dynamic_form'
gem 'jbuilder'
gem 'rack-rewrite'
gem 'mechanize', require: false

gem 'paperclip'
gem 'aws-sdk'
gem 'high_voltage'

group :production do
  # Bumping some unicorn deps so the app builds on 2.2.0
  gem 'unicorn'
  gem 'kgio', '~> 2.9.3'
  gem 'raindrops', '~> 0.13.0'

  gem 'rails_12factor'
  gem 'memcachier'
  gem 'dalli'
end
