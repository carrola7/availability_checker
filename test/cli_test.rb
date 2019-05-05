require_relative 'test_helper'

class CLITest < Minitest::Spec
  def silence
    capture_io do
      yield
    end
  end

  def capture_output
    out, _err = capture_io do
      yield
    end
    out
  end

  describe AvailabilityChecker::CLI do
    describe '#initialize' do
      it 'returns an instance of CLI' do
        cli = nil
        silence { cli = AvailabilityChecker::CLI.new }
        assert_instance_of(AvailabilityChecker::CLI, cli)
      end

      it 'prints out the command line usage with no arguments' do
        ARGV.replace []
        out = capture_output do
          AvailabilityChecker::CLI.new
        end
        assert_match 'Usage', out
      end

      it 'replaces the csv path with a -a argument' do
        ARGV.replace ['-a', 'test.csv']
        cli = AvailabilityChecker::CLI.new
        assert_equal('test.csv', cli.csv_path)
      end

      it 'replaces the csv path with a -r argument' do
        ARGV.replace ['-r', './']
        cli = AvailabilityChecker::CLI.new
        assert_equal(File.join(AvailabilityChecker::ROOT, './'), cli.csv_path)
      end

      it 'displays the options with a -h argument' do
        ARGV.replace ['-h']
        out = capture_output do
          AvailabilityChecker::CLI.new
        end
        assert_match 'Usage', out
      end

      it 'prints the available doctors with a weekday argument' do
        ARGV.replace ['-r', 'test/data/doctors.csv', 'saturday']
        out = capture_output do
          AvailabilityChecker::CLI.new
        end
        assert_match 'Dr. May', out
      end
      it 'prints a message for an invalid weekday argument' do
        ARGV.replace ['-r', 'test/data/doctors.csv', 'saturda']
        out = capture_output do
          AvailabilityChecker::CLI.new
        end
        assert_match 'Must be a valid weekday', out
      end
      it 'prints a message for an invalid file name' do
        ARGV.replace ['-r', '../test/data/foo.csv', 'saturday']
        out = capture_output do
          AvailabilityChecker::CLI.new
        end
        assert_match 'CSV file not found', out
      end
      it 'prints a message for an invalid file destination' do
        ARGV.replace ['-r', 'test/data/doctors.txt', 'saturday']
        out = capture_output do
          AvailabilityChecker::CLI.new
        end
        assert_match 'Invalid file extension', out
      end
    end

    describe '#csv_path' do
      it 'returns the default csv path' do
        cli = nil
        silence { cli = AvailabilityChecker::CLI.new }
        assert_equal(AvailabilityChecker::DEFAULT_CSV, cli.csv_path)
      end
    end
  end
end
