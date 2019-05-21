module LarvataTimesheet
  class CalendarView
    START_DAY = :sunday
    DAYS = %i(sunday monday tuesday wednesday thursday friday saturday).freeze

    def self.call(date, start_day = START_DAY)
      raise ArgumentError, "Invalid start day, please select one from #{DAYS}." unless DAYS.include?(start_day)

      date = Date.parse(date)
      start = date.beginning_of_month.beginning_of_week(start_day)
      finish = date.end_of_month.end_of_week(start_day)
      (start..finish).to_a
    end
  end
end
