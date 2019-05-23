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
      category.category = category

      expect(category).to_not(be_valid)
    end

    it 'has a positive rank' do
      activity = build(:activity, rank: 1)
      activity_with_negative_rank = build(:activity, rank: -1)
      activity_with_nil_rank = build(:activity, rank: nil)

      expect(activity.rank).to(eq(1))
      expect(activity_with_negative_rank).to_not(be_valid)
      expect(activity_with_nil_rank).to_not(be_valid)
    end

    it 'has a name' do
      activity = build(:activity, name: 'Earl')
      activity_with_no_name = build(:activity, name: nil)

      expect(activity.name).to(eq('Earl'))
      expect(activity_with_no_name).to_not(be_valid)
    end
  end
end
