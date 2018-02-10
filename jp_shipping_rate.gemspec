
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jp_shipping_rate/version"

Gem::Specification.new do |spec|
  spec.name          = "jp_shipping_rate"
  spec.version       = JPShippingRate::VERSION
  spec.authors       = ["Hanh D. TRAN"]
  spec.email         = ["tranduchanh.ms@gmail.com"]

  spec.summary       = %q{A Ruby gem for Japan shipping rate calculation.}
  spec.description   = %q{it provides EMS shipping rate calculation for Japan}
  spec.homepage      = "https://github.com/aromajoin/jp-shipping-rate"
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform.local
  spec.required_ruby_version = '>= 1.9.0'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib', 'config']

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
