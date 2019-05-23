module LarvataTimesheet
  class Activity < ApplicationRecord
    belongs_to :category, class_name: LarvataTimesheet::Activity, optional: true
    has_many :children, -> { order(rank: :asc) }, class_name: LarvataTimesheet::Activity, foreign_key: 'category_id'

    validates_presence_of :rank, :name
    validates :rank, numericality: { greater_than_or_equal_to: 1 }
    validates :enabled, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }
    validate :category_cannot_belong_to_self
    validate :activity_cannot_have_grandfather

    private

    def category_cannot_belong_to_self
      errors.add(:category, "can't belong to itself") if category == self
    end

    def activity_cannot_have_grandfather
      errors.add(:category, "does not support more than one generation") if category&.category
    end
  end
end
