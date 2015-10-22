require "rspec"
require 'byebug'
require 'require'

PROJECT_ROOT = File.expand_path('../..', __FILE__)

$LOAD_PATH << File.join(PROJECT_ROOT, 'lib', '*.rb')
