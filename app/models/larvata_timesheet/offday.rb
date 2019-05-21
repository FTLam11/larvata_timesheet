module LarvataTimesheet
  class Offday < ApplicationRecord
    self.primary_key = 'date_id'

    validates :date_id, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'only allows YYYY-MM-DD format' }
    validates :is_off, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }

    def self.around_range(date_id)
      date = Date.parse(date_id)
      start = date.beginning_of_month.beginning_of_week
      finish = date.end_of_month.end_of_week
      where("date(date_id) BETWEEN ? AND ?", start, finish)
    end
  end
end
