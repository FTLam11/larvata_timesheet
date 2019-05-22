require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(CalendarView, type: :model) do
    describe '.call' do
      MIN_DAY_COUNT = 4 * 7
      MAX_DAY_COUNT = 6 * 7

      it 'generates a range of date-like objects' do
        date = '2019-05-21'

        calendar = CalendarView.call(date)
        first_date = calendar.first
        last_date = calendar.last

        expect(first_date.date_id).to(eq('2019-04-28'))
        expect(first_date.is_off).to(be(true))
        expect(last_date.date_id).to(eq('2019-06-01'))
        expect(last_date.is_off).to(be(true))
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
