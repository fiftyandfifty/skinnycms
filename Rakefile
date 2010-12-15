require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "skinnycms"
  gem.homepage = "https://github.com/fiftyandfifty/skinnycms"
  gem.license = "MIT"
  gem.summary = "skinnycms gem"
  gem.description = "long description"
  gem.email = "ruslan.hamidullin@flatsoft.com"
  gem.authors = ["RuslanHamidullin"]
  gem.add_dependency 'devise', '1.1.rc2'
  gem.add_bundler_dependencies
end
Jeweler::RubygemsDotOrgTasks.new

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }