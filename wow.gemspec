# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wow/version'

Gem::Specification.new do |spec|
  spec.name          = 'wow'
  spec.version       = WoW::VERSION
  spec.authors       = ['Nathan Lilienthal']
  spec.email         = ['nathan@nixpulvis.com']
  spec.summary       = 'World of Warcraft API Access.'
  spec.description   = 'A ruby library for accessing World of Warcraft data from Battle.net'
  spec.homepage      = 'https://github.com/nixpulvis/wow'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'rspec', '~> 2.14'

  spec.add_dependency 'httparty', '~> 0'
end
