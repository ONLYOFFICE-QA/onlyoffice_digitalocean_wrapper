# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require_relative 'lib/onlyoffice_digitalocean_wrapper'
require_relative 'spec/spec_helper'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Release gem '
task :release_github_rubygems do
  Rake::Task['release'].invoke
  gem_name = "pkg/#{OnlyofficeDigitaloceanWrapper::NAME}-" \
             "#{OnlyofficeDigitaloceanWrapper::VERSION}.gem"
  sh('gem push --key github ' \
     '--host https://rubygems.pkg.github.com/ONLYOFFICE-QA ' \
     "#{gem_name}")
end

desc 'Check that no test droplet running right now'
task :check_no_test_droplet do
  api = OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new
  droplet_names = api.client.droplets.all.map(&:name)
  filtered_names = droplet_names.select { |name| name.start_with?(test_droplet_name_prefix) }
  raise "There are running test droplets: #{filtered_names}" unless filtered_names.empty?
end
