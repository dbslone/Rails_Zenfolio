require 'rspec'
require 'ZenfolioAPI'
require "net/http"
require "uri"
require "json"

RSpec.configure do |config|
	config.color_enabled = true
	config.formatter = 'documentation'
end