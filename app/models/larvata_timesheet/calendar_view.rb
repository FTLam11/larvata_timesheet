module LarvataTimesheet
  class CalendarView
    START_DAY = :sunday
    DAYS = %i(sunday monday tuesday wednesday thursday friday saturday).freeze

    def self.call(date_id, start_day = START_DAY)
      raise ArgumentError, "Invalid start day, please select one from #{DAYS}." unless DAYS.include?(start_day)

      date = Date.parse(date_id)
      start = date.beginning_of_month.beginning_of_week(start_day)
      fin = date.end_of_month.end_of_week(start_day)
      offdays = Offday.around_range(start, fin).all

      (start..fin).map do |day|
        offdays.detect(-> { Offday.spawn(day) }) do |off_day|
          off_day.date_id == day.to_s
        end
      end
    end
  end
end
