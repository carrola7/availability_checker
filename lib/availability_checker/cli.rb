module AvailabilityChecker
  # This class handles all the command line interface logic
  class CLI
    attr_reader :csv_path

    def initialize
      @csv_path = DEFAULT_CSV
      process_options
      if ARGV.size > 1
        puts "\nIncorrect number of arguments\n\n"
      elsif ARGV.size == 1
        print_schedule
      end
    end

    private

    def process_options
      ARGV << '-h' if ARGV.empty?
      OptionParser.new do |opts|
        opts.banner = 'Usage: ./bin/check [options] DAY_OF_THE_WEEK'
        add_option_for_absolute_paths(opts)
        add_option_for_relative_paths(opts)
        add_option_for_help(opts)
      end.parse!
    end

    def print_schedule
      weekday = ARGV.pop
      begin
        schedule = Schedule.new(csv_path)
        schedule.find_doctor(weekday) do |doctor_name|
          puts "#{doctor_name} is available"
        end
      rescue ArgumentError => e
        puts e.message
      end
    end

    def add_option_for_absolute_paths(opts)
      opts.on('-a', '--absolute CSV_PATH', 'Specify absolute path to CSV file') do |csv_path|
        @csv_path = csv_path
      end
    end

    def add_option_for_relative_paths(opts)
      opts.on('-r', '--relative CSV_PATH', 'Specify relative path to CSV file') do |csv_path|
        @csv_path = File.join(ROOT, csv_path)
      end
    end

    def add_option_for_help(opts)
      opts.on('-h', '--help', 'Show help menu') do
        puts opts
      end
    end
  end
end
