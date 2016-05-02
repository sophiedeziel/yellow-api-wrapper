#!/usr/bin/env rake

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :test => :spec

if !ENV["APPRAISAL_INITIALIZED"] && !ENV["TRAVIS"]
  task :default => :appraisal
end

require 'yard'
namespace :doc do
  YARD::Rake::YardocTask.new do |task|
    task.files = ['LICENSE.md', 'lib/**/*.rb']
    task.options = ['--markup', 'markdown']
  end
end

