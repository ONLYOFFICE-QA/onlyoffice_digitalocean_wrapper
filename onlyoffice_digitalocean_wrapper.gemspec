lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onlyoffice_digitalocean_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = 'onlyoffice_digitalocean_wrapper'
  spec.version       = OnlyofficeDigitaloceanWrapper::VERSION
  spec.authors       = ['Pavel Lobashov', 'Oleg Nazarov']
  spec.email         = %w[shockwavenn@gmail.com nazarov90@gmail.com]

  spec.summary       = 'Wrapper gem for DigitalOcean'
  spec.description   = 'Wrapper gem for DigitalOcean. Use in testing projects'
  spec.homepage      = 'https://github.com/onlyoffice-testing-robot/onlyoffice_digitalocean_wrapper'

  spec.files = `git ls-files lib LICENSE.txt README.md`.split($RS)
  spec.require_paths = ['lib']
  spec.required_ruby_version = ['>= 2.2']

  spec.add_runtime_dependency('activesupport', '~> 5')
  spec.add_runtime_dependency('droplet_kit', '~> 2')
  spec.add_runtime_dependency('onlyoffice_logger_helper', '~> 1')
  spec.license = 'AGPL-3.0'
end
