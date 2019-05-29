FactoryBot.define do
  factory :larvata_timesheet_calendar, class: 'LarvataTimesheet::Calendar', aliases: [:calendar] do
    name { "Just another calendar" }
    default { false }
  end
end
