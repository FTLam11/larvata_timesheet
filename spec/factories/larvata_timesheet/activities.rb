FactoryBot.define do
  factory :larvata_timesheet_activity, class: LarvataTimesheet::Activity, aliases: [:activity] do
    name { "Leave" }
    rank { 1 }
    enabled { true }
    category { nil }
  end
end
