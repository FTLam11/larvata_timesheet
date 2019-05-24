FactoryBot.define do
  factory :larvata_timesheet_calendar_month, class: 'LarvataTimesheet::CalendarMonth', aliases: [:calendar_month] do
    date_id { Time.zone.now.to_s(:ym) }
    enabled { false }
  end
end
