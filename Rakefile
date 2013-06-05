require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'rake/clean'

include Rake::DSL

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty --no-source -x"
  t.fork = false
end

RSpec::Core::RakeTask.new

task :default => [:spec, :features]
task :test => :spec