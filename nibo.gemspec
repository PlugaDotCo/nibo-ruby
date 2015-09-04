# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nibo/version'

Gem::Specification.new do |spec|
  spec.name          = "nibo"
  spec.version       = Nibo::VERSION
  spec.authors       = ["Arthur Granado"]
  spec.email         = ["agranado@pluga.co"]

  spec.summary       = %q{Ruby gem that allow to access Nibo API.}
  spec.description   = %q{That gem allow the developer to access Nibo's RESTful API resource.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
