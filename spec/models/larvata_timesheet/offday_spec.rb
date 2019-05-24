require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(Offday, type: :model) do
    describe '#date_id' do
      it 'has a valid format YYYY-MM-DD' do
        offday = build(:offday, date_id: '2019-05-19')
        invalid_offday = build(:offday, date_id: 'AASJKDAKSJD')

        expect(offday).to(be_valid)
        expect(invalid_offday).to_not(be_valid)
      end

      it 'is unique' do
        offday = create(:offday, date_id: '2019-05-19')
        duplicate_offday = build(:offday, date_id: '2019-05-19')

        expect(duplicate_offday).to_not(be_valid)
      end
    end

    describe '#is_off' do
      it 'has a valid boolean value do' do
        expect { create(:offday, is_off: nil) }.to(raise_error(ActiveRecord::RecordInvalid))
      end

      context 'regardless of what day it is' do
        it 'can be an off day' do
          offday = build(:offday, is_off: true)

          expect(offday.is_off).to(be(true))
        end

        it 'can be a workday' do
          offday = build(:offday, is_off: false)

          expect(offday.is_off).to(be(false))
        end
      end
    end

    describe '.spawn' do
      it 'builds a workday' do
        date = Date.parse('2019-05-21')

        offday = Offday.spawn(date)

        expect(offday.is_off).to(be(false))
      end

      it 'builds an offday' do
        date = Date.parse('2019-05-19')

        offday = Offday.spawn(date)

        expect(offday.is_off).to(be(true))
      end
    end

    describe '#as_json' do
      it 'has the required keys' do
        offday = build(:offday)

        result = JSON.parse(offday.to_json).keys

        expect(result).to(include('date_id', 'is_off'))
      end
    end
  end
end
