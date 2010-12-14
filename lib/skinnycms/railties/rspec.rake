ENV['BUNDLE_GEMFILE'] = File.dirname(__FILE__) + '/../../../spec/rails_3_0_3_root/Gemfile'

require 'rake'
require 'rspec'
require 'rspec/core/rake_task'

desc "Run the test suite"
task :spec => ['spec:setup', 'spec:models', 'spec:routing', 'spec:controllers']

namespace :spec do
  desc "Setup the test environment"
  task :setup do
    rails_path = File.expand_path(File.dirname(__FILE__) + '/../../../spec/rails_3_0_3_root')

    system "cd #{rails_path} && bundle install"
    system "cd #{rails_path} && rails generate skinnycms_cucumber_features"
  end

  desc "Test the skinnycms models"
  RSpec::Core::RakeTask.new(:models) do |task|
    rules_engine_root = File.expand_path(File.dirname(__FILE__) + '/../../..')
    task.pattern = rules_engine_root + '/spec/models/**/*_spec.rb'
  end

  desc "Test the skinnycms routing"
  RSpec::Core::RakeTask.new(:routing) do |task|
    rules_engine_root = File.expand_path(File.dirname(__FILE__) + '/../../..')
    task.pattern = rules_engine_root + '/spec/routing/**/*_spec.rb'
  end

  desc "Test the skinnycms controllers"
  RSpec::Core::RakeTask.new(:controllers) do |task|
    rules_engine_root = File.expand_path(File.dirname(__FILE__) + '/../../..')
    task.pattern = rules_engine_root + '/spec/controllers/**/*_spec.rb'
  end

  desc "Run the coverage report"
  RSpec::Core::RakeTask.new(:rcov) do |task|
    rules_engine_root = File.expand_path(File.dirname(__FILE__) + '/../../..')
    task.pattern = rules_engine_root + '/spec/lib/**/*_spec.rb'
    task.rcov=true
    task.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/}
  end
end

