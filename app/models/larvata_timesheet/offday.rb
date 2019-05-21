module LarvataTimesheet
  class Offday < ApplicationRecord
    self.primary_key = 'date_id'

    validates :date_id, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'only allows YYYY-MM-DD format' }
    validates :date_id, uniqueness: true
    validates :is_off, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }

    scope :around_range, -> (start, fin) { where("date(date_id) BETWEEN ? AND ?", start, fin) }

    def self.spawn(date)
      is_off = date.on_weekday? ? false : true
      new(date_id: date, is_off: is_off)
    end

    def as_json(*)
      super(only: [:date_id, :is_off])
    end
  end
end
