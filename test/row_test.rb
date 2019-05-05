require_relative 'test_helper'

class RowTest < Minitest::Spec
  VALID_DATA_ROW = ['Dr. May', 'ON', 'ON', 'OFF',
                    'OFF', 'OFF', 'ON', 'ON'].freeze

  INVALID_DATA_ROW = ['Dr. May', 'ON', 'ON', 'OFF',
                      'OFF', 'OFF', 'ON', 'On'].freeze

  INVALID_HEADER_ROW = ['Doctor Name', 'Mon', 'Tuesday',
                        'Wednesday', 'Thursday', 'Friday',
                        'Saturday', 'Sunday'].freeze

  describe AvailabilityChecker::Schedule::Row do
    describe '#initialize' do
      it 'returns an instance of Row' do
        row = AvailabilityChecker::Schedule::Row.new(VALID_DATA_ROW)
        assert_instance_of(AvailabilityChecker::Schedule::Row, row)
      end
      it 'throws an error for a row with invalid data' do
        assert_raises StandardError do
          AvailabilityChecker::Schedule::Row.new(INVALID_DATA_ROW)
        end
      end
      it 'throws an error for a header row with invalid data' do
        assert_raises StandardError do
          AvailabilityChecker::Schedule::Row.new(INVALID_HEADER_ROW)
        end
      end
    end

    describe '#doctor_name' do
      it 'returns the doctor\'s name from the row of data' do
        row = AvailabilityChecker::Schedule::Row.new(VALID_DATA_ROW)
        assert_equal('Dr. May', row.doctor_name)
      end
    end

    describe 'available_on?' do
      it 'returns true if a doctor is available on a given day' do
        row = AvailabilityChecker::Schedule::Row.new(VALID_DATA_ROW)
        assert(row.available_on?('Monday'))
      end
      it 'returns false if a doctor is not available on a given day' do
        row = AvailabilityChecker::Schedule::Row.new(VALID_DATA_ROW)
        refute(row.available_on?('Wednesday'))
      end
    end
  end
end
