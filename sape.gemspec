# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sape/version'

Gem::Specification.new do |spec|
  spec.name          = "sape"
  spec.version       = Sape::VERSION
  spec.authors       = ["Pavel Rodionov"]
  spec.email         = ["pasha.rod@mail.ru"]
  spec.summary       = "Sape.ru Ruby On Rails module"
  spec.description   = "Sape.ru links exchange system integration"
  spec.homepage      = "https://github.com/krim/sape"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.0.0"
  spec.add_dependency "nokogiri"
  spec.add_dependency "domainatrix"
  spec.add_dependency "json"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-activemodel-mocks"
  spec.add_development_dependency "fakeweb"
  spec.add_development_dependency "fakeweb-matcher"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
end
