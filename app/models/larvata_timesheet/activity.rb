module LarvataTimesheet
  class Activity < ApplicationRecord
    belongs_to :category, class_name: 'LarvataTimesheet::Activity', optional: true
    has_many :children, -> { order(:rank) }, class_name: 'LarvataTimesheet::Activity', foreign_key: 'category_id'

    validates_presence_of :rank, :name
    validates :rank, numericality: { greater_than_or_equal_to: 1 }
    validates :enabled, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }
    validate :category_cannot_belong_to_self
    validate :category_cannot_support_deep_generations

    scope :categories, -> { where(category: nil).order(:rank) }
    scope :to_tree, -> { order("field(id, #{to_tree_ids.join(',')})") }

    class << self
      private

      def to_tree_ids
        [].tap do |result|
          includes(:children).categories.each do |category|
            result << category.id << category.children.pluck(:id)
          end
        end.flatten
      end
    end

    private

    def category_cannot_belong_to_self
      errors.add(:category, "can't belong to itself") if category == self
    end

    def category_cannot_support_deep_generations
      errors.add(:category, "does not support more than one generation") if category&.category
    end
  end
end
