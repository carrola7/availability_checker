require_relative 'availability_checker/schedule'
require_relative 'availability_checker/schedule/row'
require_relative 'availability_checker/cli'
require 'optparse'
require 'csv'

module AvailabilityChecker
  ROOT = File.expand_path('../', File.dirname(__FILE__)).freeze
  DEFAULT_CSV = File.join(ROOT, 'data/doctors.csv').freeze
end

AvailabilityChecker::CLI.new
