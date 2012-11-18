# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pv/version'

Gem::Specification.new do |gem|
  gem.name          = "pv"
  gem.version       = Pv::VERSION
  gem.authors       = ["Tom Scott"]
  gem.email         = ["tubbo@psychedeli.ca"]
  gem.description   = %q{A command-line interface to Pivotal Tracker.}
  gem.summary       = %q{A command-line interface to Pivotal Tracker.}
  gem.homepage      = "http://github.com/tubbo/pv"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'pivotal-tracker'
  gem.add_dependency 'thor'
  gem.add_dependency 'active_support'
end
