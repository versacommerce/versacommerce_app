# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "versacommerce_app/version"

Gem::Specification.new do |s|
  s.name        = "versacommerce_app"
  s.version     = VersacommerceApp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "VersaCommerce"
  s.email       = ["support@versacommerce.de"]
  s.homepage    = "http://www.versacommerce.de"
  s.summary     = %q{This gem is used to get quickly started with the VersaCommerce API}
  s.description = %q{This generator creates a basic sessions controller for authenticating with your Shop. Also a home controller which lets you access your shop easily.}

  s.add_runtime_dependency('rails', '>= 3.1', '< 5.0')
  s.add_runtime_dependency('versacommerce_api', '~> 1.0.8')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
