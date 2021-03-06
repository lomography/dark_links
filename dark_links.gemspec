# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dark_links/version'

Gem::Specification.new do |s|
  s.name          = 'dark_links'
  s.version       = DarkLinks::VERSION
  s.date          = '2016-01-13'
  s.summary       = "Tries to find broken links."
  s.description   = "Provides concerns to find broken urls in blobs of markup and markdown."
  s.authors       = ["Michael Emhofer", "Martin Sereinig", "Markus Wegscheider"]
  s.email         = 'dev@lomography.com'

  s.files         = `git ls-files`.split($/)
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'httparty'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock'
end
