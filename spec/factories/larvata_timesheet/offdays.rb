FactoryBot.define do
  factory :larvata_timesheet_offday, class: 'LarvataTimesheet::Offday', aliases: [:offday] do
    date_id { "2019-05-19" }
    is_off { true }
  end
end
