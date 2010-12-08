require "skinnycms"
require "rails"
require "action_controller"

module SkinnyCMS
  class Engine < Rails::Engine
    rake_tasks do
       load "skinnycms/railties/tasks.rake"
    end
  end
end
