module LarvataTimesheet
  class Activity < ApplicationRecord
    belongs_to :category, class_name: 'LarvataTimesheet::Activity', optional: true

    validates_presence_of :rank, :name
    validates :rank, numericality: { greater_than_or_equal_to: 1 }
    validate :category_cannot_belong_to_self

    private

    def category_cannot_belong_to_self
      errors.add(:category, "can't belong to itself") if category == self
    end
  end
end
