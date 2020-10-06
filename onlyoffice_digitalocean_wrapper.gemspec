# frozen_string_literal: true

require_relative 'lib/onlyoffice_digitalocean_wrapper/version'

Gem::Specification.new do |s|
  s.name = OnlyofficeDigitaloceanWrapper::NAME
  s.version = OnlyofficeDigitaloceanWrapper::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.5'
  s.authors = ['ONLYOFFICE', 'Pavel Lobashov', 'Oleg Nazarov']
  s.email = %w[shockwavenn@gmail.com nazarov90@gmail.com]
  s.summary = 'Wrapper gem for DigitalOcean'
  s.description = 'Wrapper gem for DigitalOcean. Use in testing projects'
  s.homepage = "https://github.com/onlyoffice-testing-robot/#{s.name}"
  s.metadata = {
    'bug_tracker_uri' => "#{s.homepage}/issues",
    'changelog_uri' => "#{s.homepage}/blob/master/CHANGELOG.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{s.name}",
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage
  }
  s.files = Dir['lib/**/*']
  s.license = 'AGPL-3.0'
  s.add_runtime_dependency('droplet_kit', '~> 3')
  s.add_runtime_dependency('onlyoffice_logger_helper', '~> 1')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rubocop', '0.92.0')
  s.add_development_dependency('rubocop-performance', '1.8.1')
  s.add_development_dependency('rubocop-rake', '0.5.1')
  s.add_development_dependency('rubocop-rspec', '1.43.2')
end
