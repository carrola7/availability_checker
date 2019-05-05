require_relative 'test_helper'

class ScheduleTest < Minitest::Spec
  describe AvailabilityChecker::Schedule do
    describe '#initiailize' do
      it 'raises an exception if the file is not a csv' do
        assert_raises ArgumentError do
          AvailabilityChecker::Schedule.new('foo')
        end
      end
      it 'returns an instance of Schedule' do
        @schedule = AvailabilityChecker::Schedule.new('data/doctors.csv')
        assert_instance_of(AvailabilityChecker::Schedule, @schedule)
      end
    end

    describe '#find_doctor' do
      it 'raises an exception if a valid day of the week is not passed in' do
        @schedule = AvailabilityChecker::Schedule.new('data/doctors.csv')
        assert_raises ArgumentError do
          @schedule.find_doctor('foo')
        end
      end

      it 'yields the correct doctors names for a given day' do
        @schedule = AvailabilityChecker::Schedule.new('data/doctors.csv')
        doctor_names = []
        @schedule.find_doctor('Monday') do |doc_name|
          doctor_names << doc_name
        end
        assert_equal(['Dr. Kim', 'Dr. May'], doctor_names)
      end

      it 'yields the correct doctors names regardless of capitalization' do
        @schedule = AvailabilityChecker::Schedule.new('data/doctors.csv')
        doctor_names = []
        @schedule.find_doctor('tuesday') do |doc_name|
          doctor_names << doc_name
        end
        assert_equal(['Dr. Adamski', 'Dr. May'], doctor_names)
      end
    end
  end
end
