require 'aruba/cucumber'
require 'methadone/cucumber'

# NOTE: Modified Aruba's default because it couldn't find things in it's path
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../..')}#{File::PATH_SEPARATOR}#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
end

After do
  ENV['RUBYLIB'] = @original_rubylib
end

Before do
  @aruba_timeout_seconds = 20
end