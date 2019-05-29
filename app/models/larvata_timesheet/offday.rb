module LarvataTimesheet
  class Offday < ApplicationRecord
    self.primary_key = 'date_id'

    belongs_to :calendar, foreign_key: 'larvata_timesheet_calendar_id'

    DATE_REGEX = /\A\d{4}-[0-1]{1}\d{1}-[0-3]{1}\d{1}\z/
    private_constant :DATE_REGEX

    validates :date_id, format: { with: DATE_REGEX, message: 'only allows YYYY-MM-DD format' }
    validates :date_id, uniqueness: true
    validates :is_off, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }

    scope :for_calendar, -> (calendar_id) { where(larvata_timesheet_calendar_id: calendar_id) }
    scope :between, -> (start, fin) { where("date(date_id) BETWEEN ? AND ?", start, fin) }

    def self.around_range(calendar_id, start, fin)
      if calendar_id
        for_calendar(calendar_id).merge(between(start, fin))
      else
        between(start, fin).merge(Calendar.default)
      end
    end

    def self.spawn(date)
      is_off = date.on_weekday? ? false : true
      new(date_id: date, is_off: is_off)
    end

    def as_json(*)
      super(only: [:date_id, :is_off])
    end
  end
end
