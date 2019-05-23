require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(Activity, type: :model) do
    describe 'associations' do
      it 'may belong to a parent category' do
        category = create(:activity, name: 'Leave')

        activity = create(:activity, category: category)

        expect(category.category).to(be(nil))
        expect(activity.category).to(be(category))
      end

      it 'may have children' do
        category = create(:activity, name: 'Leave')
        activity = create(:activity, category: category)

        expect(category.children).to(include(activity))
      end

      it 'may only have one generation of children' do
        category = create(:activity, name: 'Leave')
        activity = create(:activity, category: category)
        grandchild_activity = build(:activity, category: activity)

        expect(grandchild_activity).to_not(be_valid)
      end
    end

    it 'may not belong to itself' do
      category = create(:activity)
      category.category = category

      expect(category).to_not(be_valid)
    end

    describe 'attributes' do
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

      it 'may be enabled' do
        activity = build(:activity, enabled: true)
        bad_activity = build(:activity, enabled: nil)

        expect(activity.enabled).to(be(true))
        expect(bad_activity).to_not(be_valid)
      end
    end
  end
end
