require 'bundler/gem_tasks'

# Use Gemfury release tasks instead of Bundler's
require 'gemfury'
require 'gemfury/command'

namespace 'fury' do
  desc "Build gem and push it to Gemfury"
  task :release, :gemspec do |t, args|
    gemspec = args[:gemspec] ||
              FileList["#{Dir.pwd}/*.gemspec"][0]

    if gemspec.nil? || !File.exist?(gemspec)
      puts "No gemspec found"
    else
      puts "Building #{File.basename(gemspec)}"
      spec = Gem::Specification.load(gemspec)
      Gem::Builder.new(spec).build
      gemfile = File.basename(spec.cache_file)
      Gemfury::Command::App.start(['push', gemfile])
    end
  end
end

namespace 'gemfury' do
  task :release => 'fury:release'
end


require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec