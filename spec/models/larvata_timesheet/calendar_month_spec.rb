require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(CalendarMonth, type: :model) do
    describe 'attributes' do
      it 'has a valid format YYYY-MM date_id' do
        calendar_month = build(:calendar_month, date_id: '2019-05')
        invalid_calendar_month = build(:calendar_month, date_id: 'AASJKDAKSJD')

        expect(calendar_month).to(be_valid)
        expect(invalid_calendar_month).to_not(be_valid)
      end

      it 'has a unique date_id' do
        create(:calendar_month, date_id: '2019-05')
        duplicate_calendar_month = build(:calendar_month, date_id: '2019-05')

        expect(duplicate_calendar_month).to_not(be_valid)
      end

      it 'may be enabled' do
        calendar_month = build(:calendar_month, enabled: true)
        bad_calendar_month = build(:calendar_month, enabled: nil)

        expect(calendar_month.enabled).to(be(true))
        expect(bad_calendar_month).to_not(be_valid)
      end
    end

    describe '#as_json' do
      it 'has the required keys' do
        calendar_month = build(:calendar_month)

        result = JSON.parse(calendar_month.to_json).keys

        expect(result).to(include('date_id', 'enabled', 'persisted'))
      end
    end
  end
end
