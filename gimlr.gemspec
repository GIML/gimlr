lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gimlr/version'

Gem::Specification.new do |s|
  s.name        = 'gimlr'
  s.version     = Gimlr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['gazay']
  s.licenses    = ['MIT']
  s.email       = ['alex.gaziev@gmail.com']
  s.homepage    = 'https://github.com/gazay/gimlr'
  s.summary     = %q{Ruby parser for GIML}
  s.description = %q{First, fast and simple parser for GIML}

  s.rubyforge_project = 'gimlr'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'benchmark-ips'
  s.add_development_dependency 'ruby-prof'
  s.add_development_dependency 'toml-rb'
end
