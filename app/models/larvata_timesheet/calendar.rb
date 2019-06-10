module LarvataTimesheet
  class Calendar < ApplicationRecord
    has_many :offdays, foreign_key: 'larvata_timesheet_calendar_id', dependent: :delete_all

    validates :name, presence: true, uniqueness: true
    validates :default, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }
    validate :default_true_only_has_one_record, if: Proc.new { |c| c.default }

    scope :default, -> { where(default: true) }

    def as_json(*)
      super(except: [:created_at, :updated_at])
    end

    private

    def default_true_only_has_one_record
      if self.class.default.exists? and !self.class.default.include?(self)
        errors.add(:default, "can't be set since another calendar already is")
      end
    end
  end
end
