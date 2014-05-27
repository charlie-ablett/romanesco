# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'romanesco/version'

Gem::Specification.new do |spec|
  spec.name          = "romanesco"
  spec.version       = Romanesco::VERSION
  spec.authors       = ["Charlie Ablett", "Craig Taube-Schock"]
  spec.email         = ["charlie@enspiral.com", "craig.schock@enspiral.com"]
  spec.description   = "Parses simple mathematical expressions, creates a fully object-oriented expression tree. Evaluation can have injected variables."
  spec.summary       = "Parse math expressions and evaluate with injected variables"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
