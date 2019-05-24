class CreateLarvataTimesheetCalendarMonths < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_timesheet_calendar_months, id: false do |t|
      t.string :date_id, null: false
      t.boolean :enabled, null: false

      t.timestamps

      t.index :date_id, unique: true
    end
  end
end
