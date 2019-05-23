require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(Activity, type: :model) do
    it 'may belong to a parent category' do
      category = create(:activity, name: 'Leave')

      activity = create(:activity, category: category)

      expect(category.category).to(be(nil))
      expect(activity.category).to(be(category))
    end

    it 'may not belong to itself' do
      category = create(:activity)

      expect { category.update!(category: category) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
