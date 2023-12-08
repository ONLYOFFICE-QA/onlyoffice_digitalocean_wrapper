# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start

if ENV['CI']
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end
require 'onlyoffice_digitalocean_wrapper'
require 'securerandom'

# Any existing Droplet name
# @return [String] name of droplet
def existing_droplet
  'wrata.teamlab.info'
end

# Any existing Droplet IP
# @return [String] ip of droplet
def existing_droplet_ip
  '138.197.104.24'
end

# Prefix for test droplet name
# @return [String]
def test_droplet_name_prefix
  'wrapper-test-'
end
