module AvailabilityChecker
  class Schedule
    # This class provides some convenience methods for interacting with
    # the rows of data in the CSV file
    class Row
      def initialize(data)
        @data = data
        validate
      end

      def doctor_name
        @data[0]
      end

      def available_on?(weekday)
        @data[VALID_WEEKDAYS.find_index(weekday.downcase) + 1] == 'ON'
      end

      private

      def validate
        raise StandardError, 'There is a problem with your CSV file' unless data_valid?
      end

      def data_valid?
        @data.size == 8 && (valid_headers? || valid_data_row?)
      end

      def valid_headers?
        @data.slice(1..-1) == VALID_WEEKDAYS.map(&:capitalize)
      end

      def valid_data_row?
        @data.slice(1..-1).all? do |attendance|
          attendance.match(/\b(ON|OFF)\b/)
        end
      end
    end
  end
end
