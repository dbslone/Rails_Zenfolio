# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ZenfolioAPI/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Slone"]
  gem.email         = ["dbslone@gmail.com"]
  gem.description   = %q{Basic implementation of the Zenfolio API.}
  gem.summary       = %q{Currently just a basic implementation of the Zenfolio API with features to list all galleries and photos, and get all the information about a gallery or photo.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ZenfolioAPI"
  gem.require_paths = ["lib"]
  gem.version       = ZenfolioAPI::VERSION

  gem.add_development_dependency "rspec", "~> 2.6"
end
