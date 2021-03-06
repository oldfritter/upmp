# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upmp/version'

Gem::Specification.new do |spec|
  spec.name          = "upmp"
  spec.version       = Upmp::VERSION
  spec.authors       = ["oldfritter"]
  spec.email         = ["leon.zcf@gmail.com"]
  spec.summary       = %q{An simple upmp gem}
  spec.description   = %q{An simple upmp gem}
  spec.homepage      = "https://github.com/oldfritter/upmp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake"
end
