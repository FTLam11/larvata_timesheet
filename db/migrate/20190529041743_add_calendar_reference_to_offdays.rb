class AddCalendarReferenceToOffdays < ActiveRecord::Migration[5.1]
  def change
    add_reference :larvata_timesheet_offdays, :larvata_timesheet_calendar, foreign_key: true
  end
end
