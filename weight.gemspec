lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "weight/version"

Gem::Specification.new do |spec|
  spec.name = "weight"
  spec.version = "0.0.3"
  spec.authors = ["Jordan Brock"]
  spec.email = ["jordan@brock.id.au"]
  spec.summary = "stores weight values as a big decimal"
  spec.description = "stores weight values as a big decimal"
  spec.homepage = ""
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rdoc"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "sqlite3"
end
