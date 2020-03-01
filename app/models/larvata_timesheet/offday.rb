module LarvataTimesheet
  class Offday < ApplicationRecord
    self.primary_key = 'date_id'

    belongs_to :calendar, foreign_key: 'larvata_timesheet_calendar_id'

    DATE_REGEX = /\A\d{4}-[0-1]{1}\d{1}-[0-3]{1}\d{1}\z/
    private_constant :DATE_REGEX

    validates :date_id, format: { with: DATE_REGEX, message: 'only allows YYYY-MM-DD format' }
    validates :date_id, uniqueness: true
    validates :is_off, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }
    validate :valid_date_id

    scope :for_calendar, -> (calendar_id) { where(larvata_timesheet_calendar_id: calendar_id) }
    scope :between, -> (start, fin) { where("date(date_id) BETWEEN ? AND ?", start, fin) }

    def self.around_range(calendar_id, start, fin)
      if calendar_id
        joins(:calendar).for_calendar(calendar_id).merge(between(start, fin))
      else
        joins(:calendar).between(start, fin).merge(Calendar.default)
      end
    end

    def self.spawn(date)
      new(date_id: date, is_off: date.on_weekend?)
    end

    def as_json(*)
      super(only: [:date_id, :is_off])
    end

    private

    def valid_date_id
      Date.parse(date_id)
    rescue ArgumentError
      errors.add(:date_id, "must be a valid date")
    end
  end
end
