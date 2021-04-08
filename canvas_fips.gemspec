$:.push File.expand_path("../lib", __FILE__)

require "canvas_fips/version"

Gem::Specification.new do |s|
  s.name        = "canvas_fips"
  s.version     = CanvasFips::VERSION
  s.authors     = ["Atomic Jolt", "Matt Petro"]
  s.email       = ["matt.petro@atomicjolt.com"]
  s.homepage    = "https://github.com/atomicjolt/canvas_fips"
  s.summary     = "This plugin patches some FIPS compliance issues in Canvas."
  s.license     = "AGPL-3.0"
  s.extra_rdoc_files = ["README.md"]

  s.required_ruby_version = ">= 2.5"

  s.files = Dir["{app,config,lib}/**/*"]

  s.add_dependency "rails", ">= 5.0"
end
