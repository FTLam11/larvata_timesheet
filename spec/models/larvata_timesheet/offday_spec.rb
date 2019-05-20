require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(Offday, type: :model) do
    describe '#date_id' do
      it 'has a valid format YYYY-MM-DD' do
        offday = build(:offday, date_id: '2019-05-19')
        invalid_offday = build(:offday, date_id: 'AASJKDAKSJD')

        expect(offday.valid?).to(be(true))
        expect(invalid_offday.valid?).to(be(false))
      end
    end
  end
end
