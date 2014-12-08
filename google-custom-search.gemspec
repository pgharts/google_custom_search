# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google_custom_search"

Gem::Specification.new do |s|
  s.name        = "google_custom_search"
  s.version     = '1.0.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Sipple"]
  s.email       = ["sipple@trustarts.org"]
  s.homepage    = "https://github.com/pgharts/google_custom_search/"
  s.summary     = %q{Interface for google custom search}
  s.description = %q{Provides access to google custom search that can be integrated with a website.}

  s.add_dependency 'hpricot'

  ignores = if File.exist?('.gitignore')
              File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
            else
              []
            end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]
end
