require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(Activity, type: :model) do
    describe 'associations' do
      it 'may belong to a parent category' do
        category = build(:activity, name: 'Leave')

        activity = build(:activity, category: category)

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

        expect(grandchild_activity).to(be_invalid)
      end

      it 'may not belong to itself' do
        category = build(:activity)
        category.category = category

        expect(category).to(be_invalid)
      end
    end

    describe 'attributes' do
      it 'has a positive rank' do
        activity = build(:activity, rank: 1)

        expect(activity.rank).to(eq(1))
      end

      it 'has a name' do
        activity = build(:activity, name: 'Earl')

        expect(activity.name).to(eq('Earl'))
      end

      it 'has a valid name' do
        activity_with_no_name = build(:activity, name: nil)

        expect(activity_with_no_name).to(be_invalid)
      end

      it 'may be enabled' do
        activity = build(:activity, enabled: true)
        bad_activity = build(:activity, enabled: nil)

        expect(activity).to(be_valid)
        expect(bad_activity).to(be_invalid)
      end
    end

    describe '.to_tree' do
      it 'returns an ordered list of enabled parent and child activities' do
        a_category = create(:activity)
        b_category = create(:activity)
        b_1_activity = create(:activity, category: b_category)
        b_2_activity = create(:activity, category: b_category, enabled: false)
        a_1_activity = create(:activity, category: a_category)
        a_2_activity = create(:activity, category: a_category)
        expected = [
          a_category,
          a_1_activity,
          a_2_activity,
          b_category,
          b_1_activity,
        ]

        result = Activity.to_tree

        expect(result).to(eq(expected))
      end
    end

    describe '#as_json' do
      it 'has the required keys' do
        activity = build(:activity)

        result = JSON.parse(activity.to_json).keys

        expect(result).to(include('id', 'category_id', 'rank', 'name', 'enabled'))
      end
    end
  end
end
