module LarvataTimesheet
  class Calendar < ApplicationRecord

    validates :name, presence: true, uniqueness: true
    validates :default, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }
    validate :default_true_only_has_one_record

    private

    def default_true_only_has_one_record
      errors.add(:default, "can't be default since another calendar already is") if self.class.where(default: true).exists?
    end
  end
end
