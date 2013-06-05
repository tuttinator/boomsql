# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boomsql/version'

Gem::Specification.new do |spec|
  spec.name          = "boomsql"
  spec.version       = Boomsql::VERSION
  spec.authors       = ["Caleb Tutty"]
  spec.email         = ["caleb@prettymint.co.nz"]
  spec.description   = %q{CLI app that uses the TinyTDS interface to the TranscribeMe MSSQL database on Windows Azure, using only SQL readonly queries for development purposes}
  spec.summary       = %q{CLI app to execute SQL readonly queries on the TranscribeMe MSSQL database}
  spec.homepage      = ""
  spec.license       = "Copyright Caleb Tutty"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake', '~> 0.9.2'
  spec.add_dependency 'methadone', '~> 1.3.0'
  spec.add_dependency 'tiny_tds'
end
