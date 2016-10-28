# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onlyoffice_digitalocean_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = 'onlyoffice_digitalocean_wrapper'
  spec.version       = OnlyofficeDigitaloceanWrapper::VERSION
  spec.authors       = ['Pavel Lobashov', 'Oleg Nazarov']
  spec.email         = ['shockwavenn@gmail.com', 'nazarov90@gmail.com']

  spec.summary       = 'Wrapper gem for DigitalOcean'
  spec.description   = 'Wrapper gem for DigitalOcean'
  spec.homepage      = 'https://github.com/onlyoffice-testing-robot/onlyoffice_digitalocean_wrapper'

  spec.files = `git ls-files lib LICENSE.txt README.md`.split($RS)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
