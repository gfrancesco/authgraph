# -*- encoding: utf-8 -*-
# $:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = %q{authgraph}
  s.summary = %q{HMAC API authentication inspired from Amazon AWS signature v4}
  s.description = %q{HMAC-SHA256/512 request signature verification against per user secret-key}
  s.homepage = %q{https://github.com/gfrancesco/authgraph}
  s.version = File.read(File.join(File.dirname(__FILE__), 'VERSION'))
  s.authors = ["Francesco Gianni"]
  s.email = "gfrancesco@gmail.com"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.4.0"
  s.add_development_dependency "actionpack", "~> 4.0.0.beta"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
