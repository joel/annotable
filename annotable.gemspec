$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "annotable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "annotable"
  spec.version     = Annotable::VERSION
  spec.authors     = ["Joel AZEMAR"]
  spec.email       = ["joel.azemar@gmail.com"]
  spec.homepage    = "http://mygemserver.com"
  spec.summary     = "Summary of Annotable."
  spec.description = "Description of Annotable."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # spec.add_dependency "rails", "~> 6.0.1"

  # Load only what you need\
  spec.add_dependency "actionpack", "~> 6.0.1"
  spec.add_dependency "activemodel", "~> 6.0.1"
  spec.add_dependency "activerecord", "~> 6.0.1"
  spec.add_dependency "activesupport", "~> 6.0.1"
  spec.add_dependency "activejob", "~> 6.0.1"
  spec.add_dependency "railties", "~> 6.0.1"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "pry-byebug"
end
