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
  gem.summary = "Lightweight CMS"
  gem.description = "Lightweight CMS which leverages the lastest external social networking APIs"
  gem.email = ["info@fiftyandfifty.org"]
  gem.authors = ["RuslanHamidullin", "BryanShanaver"]
  gem.add_dependency 'devise', '1.2.rc'
  gem.add_bundler_dependencies
end
Jeweler::RubygemsDotOrgTasks.new

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }