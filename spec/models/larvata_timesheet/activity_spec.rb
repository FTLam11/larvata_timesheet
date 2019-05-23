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

    it 'has a positive rank' do
      activity = build(:activity, rank: 1)

      expect(activity.rank).to(eq(1))
      expect { create(:activity, rank: -1) }.to(raise_error(ActiveRecord::RecordInvalid))
      expect { create(:activity, rank: nil) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end
