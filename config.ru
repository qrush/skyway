# This file is used by Rack-based servers to start the application.

require 'rack-rewrite'
 
DOMAIN = 'aqueousband.net'
 
# Redirect to the www version of the domain in production
use Rack::Rewrite do
  r301 %r{.*}, "http://#{DOMAIN}$&", :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] != DOMAIN && ENV['RAILS_ENV'] == "production"
  }
end

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
