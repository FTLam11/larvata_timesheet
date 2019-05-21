module LarvataTimesheet
  class Offday < ApplicationRecord
    self.primary_key = 'date_id'

    validates :date_id, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'only allows YYYY-MM-DD format' }
    validates :is_off, inclusion: { in: [true, false], message: 'only allows a valid boolean value' }
  end
end
