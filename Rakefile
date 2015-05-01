require 'rspec/core/rake_task'
begin
  require 'puppetlabs_spec_helper/rake_tasks'
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

 
desc "Build the module"
task :build do
  `puppet module build`
end
