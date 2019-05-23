module LarvataTimesheet
  class Activity < ApplicationRecord
    belongs_to :category, class_name: 'LarvataTimesheet::Activity', optional: true

    validate :category_cannot_belong_to_self

    private

    def category_cannot_belong_to_self
      errors.add(:category, "can't belong to itself") if category == self
    end
  end
end
