module AvailabilityChecker
  # This class handles the processing of the CSV file
  class Schedule
    VALID_WEEKDAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

    attr_reader :csv_path

    def initialize(csv_path)
      raise ArgumentError, 'CSV file not found' unless File.exist? csv_path
      raise ArgumentError, 'Invalid file extension' unless File.extname(csv_path) == '.csv'

      @csv_path = csv_path
    end

    def find_doctor(weekday)
      raise ArgumentError, 'Must be a valid weekday' unless valid_weekday? weekday

      CSV.foreach(csv_path) do |data_row|
        row = Row.new(data_row)
        yield row.doctor_name if block_given? && row.available_on?(weekday)
      end
    end

    private

    def valid_weekday?(weekday)
      VALID_WEEKDAYS.include? weekday.downcase
    end
  end
end
