$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "formtastic_kramdown/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "formtastic_kramdown"
  s.version     = FormtasticKramdown::VERSION
  s.authors     = ["Hayden Ball"]
  s.email       = ["hayden@haydenball.me.uk"]
  s.summary     = "Provides a kramdown input for formtastic"
  s.description = s.summary
  s.license     = "BSD 3-Clause"

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.1.0.rc2'
  s.add_dependency 'formtastic'
  s.add_dependency 'kramdown'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'

  s.add_development_dependency 'sqlite3'
end
