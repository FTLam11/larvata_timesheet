require 'rails_helper'

module LarvataTimesheet
  RSpec.describe Calendar, type: :model do
    it 'has a name' do
      calendar = build(:calendar, name: 'Yo')
      calendar_with_no_name = build(:calendar, name: '')

      expect(calendar).to(be_valid)
      expect(calendar_with_no_name).to_not(be_valid)
    end

    it 'has a unique name' do
      create(:calendar, name: 'Yo')

      duplicate_calendar = build(:calendar, name: 'Yo')

      expect(duplicate_calendar).to_not(be_valid)
    end

    it 'has a default' do
      calendar = build(:calendar, default: true)

      expect(calendar).to(be_valid)
    end

    it 'has only one active default' do
      create(:calendar, default: true)

      default_calendar = build(:calendar, name: 'Default', default: true)

      expect(default_calendar).to_not(be_valid)
    end
  end
end
