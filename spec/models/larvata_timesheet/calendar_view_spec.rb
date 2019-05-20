require 'spec_helper'

module LarvataTimesheet
  class CalendarView
    START_DAY = :sunday
    DAYS = %i(sunday monday tuesday wednesday thursday friday saturday).freeze

    def self.call(date, start_day = START_DAY)
      raise ArgumentError, "Invalid start day, please select one from #{DAYS}." unless DAYS.include?(start_day)

      date = Date.parse(date)
      start = date.beginning_of_month.beginning_of_week(start_day)
      finish = date.end_of_month.end_of_week(start_day)
      (start..finish).to_a
    end
  end

  RSpec.describe(CalendarView, type: :model) do
    describe '#dates' do
      MIN_DAY_COUNT = 28
      MAX_DAY_COUNT = 42
      let(:day_count_range) { (MIN_DAY_COUNT..MAX_DAY_COUNT) }

      it 'has a collection of date like objects' do
        date = Time.zone.now

        calendar = CalendarView.call(date.to_s(:f))

        expect(day_count_range).to(include(calendar.size))
      end

      context 'with the first day of a non-leap February falling on Sunday' do
        it 'spans 4 weeks (28 days)' do
          date = Time.zone.parse('2015-02-01')

          calendar = CalendarView.call(date.to_s(:f))

          expect(calendar.size).to(eq(MIN_DAY_COUNT))
        end
      end

      context 'with the first date of a month falling on a Saturday' do
        it 'spans 6 weeks (42 days)' do
          date = Time.zone.parse('2019-06-01')

          calendar = CalendarView.call(date.to_s(:f))

          expect(calendar.size).to(eq(MAX_DAY_COUNT))
        end
      end

      it 'raises an error when given an invalid start day' do
        date = Time.zone.now

        expect { CalendarView.call(date, 'ASDFGHJKL;') }.to(raise_error(ArgumentError))
      end
    end
  end
end
