# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weight/version'

Gem::Specification.new do |spec|
  spec.name          = "weight"
  spec.version       = "0.0.2"
  spec.authors       = ["Jordan Brock"]
  spec.email         = ["jordan@brock.id.au"]
  spec.summary       = %q{stores weight values as a big decimal}
  spec.description   = %q{stores weight values as a big decimal}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
