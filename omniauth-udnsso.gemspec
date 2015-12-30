# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-udnsso/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ren Mian"]
  gem.email         = ["annerenmian@163.com"]
  gem.description   = %q{Official OmniAuth strategy for Udnsso.}
  gem.summary       = %q{Official OmniAuth strategy for Udnsso.}
  gem.homepage      = "http://udn.yyuap.com/"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-udnsso"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Udnsso::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
