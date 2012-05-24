# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "peekandpick/version"

Gem::Specification.new do |s|
  s.name        = "peekandpick"
  s.version     = Peekandpick::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Praveen Murugesan, Charles Copprell"]
  s.email       = ["lefthandmagic@gmail.com, chowdy@gmail.com"]
  s.homepage    = "http://www.chaistop.com/"
  s.summary     = %q{URI content preview gem}
  s.description = %q{This gem is used to preview various URIs and provide formatted previews for images/videos/links}
  s.add_dependency('rinku', '~> 1.5.1')
  s.add_dependency('tag_helper', '~> 0.0.3')
  s.add_dependency('fastimage', '~> 1.2.13')
  s.add_dependency('nokogiri')
  s.rubyforge_project = "peekandpick"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
