FactoryBot.define do
  factory :larvata_timesheet_activity, class: LarvataTimesheet::Activity, aliases: [:activity] do
    name { "Leave" }
    rank { 1 }
    enabled { true }
    category_id { nil }
  end
end
