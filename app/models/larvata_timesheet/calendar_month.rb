module LarvataTimesheet
  class CalendarMonth < ApplicationRecord
    self.primary_key = 'date_id'

    DATE_REGEX = /\A\d{4}-[0-1]{1}\d{1}\z/
    private_constant :DATE_REGEX

    validates :date_id, format: { with: DATE_REGEX, message: 'only allows YYYY-MM format' }
    validates :date_id, uniqueness: true
    validates :enabled, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }

    def as_json(*)
      super(only: [:date_id, :enabled]).tap do |hash|
        hash[:persisted] = persisted?
      end
    end
  end
end
