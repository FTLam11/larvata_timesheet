require 'spec_helper'

module LarvataTimesheet
  class CalendarView
    attr_reader :date, :start_day

    START_DAY = :sunday

    def initialize(date, start_day = START_DAY)
      @date = Date.parse(date)
      @start_day = start_day
    end

    def dates
      start = date.beginning_of_month.beginning_of_week(start_day)
      finish = date.end_of_month.end_of_week(start_day)
      (start..finish).to_a
    end
  end

  RSpec.describe(CalendarView, type: :model) do
    let(:day_count_range) { (35..42) }

    it 'has a date range' do
      date = Time.zone.now

      calendar = CalendarView.new(date.to_s(:f))

      expect(day_count_range).to(include(calendar.dates.size))
    end
  end
end
