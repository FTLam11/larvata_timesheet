$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "larvata_timesheet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "larvata_timesheet"
  spec.version     = LarvataTimesheet::VERSION
  spec.authors     = ["Frank Lam"]
  spec.email       = ["ryzingsun11@yahoo.com"]
  spec.homepage    = "https://github.com/FTLam11/larvata_timesheet"
  spec.summary     = "Rails engine plugin for timesheets"
  spec.description = "Rails engine plugin for timesheets"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.1.4"

  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "rails-controller-testing"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "spring"
  spec.add_development_dependency "spring-commands-rspec"
end
