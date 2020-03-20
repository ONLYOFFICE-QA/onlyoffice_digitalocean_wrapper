# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Release gem '
task :release_github_rubygems do
  Rake::Task['release'].invoke
  gem_name = "pkg/#{OnlyofficeDigitaloceanWrapper::NAME}-"\
              "#{OnlyofficeDigitaloceanWrapper::VERSION}.gem"
  `gem push --key github \
   --host https://rubygems.pkg.github.com/onlyoffice-testing-robot #{gem_name}`
end
