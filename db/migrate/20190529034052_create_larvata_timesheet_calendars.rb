class CreateLarvataTimesheetCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_timesheet_calendars do |t|
      t.string :name
      t.boolean :default, default: false

      t.timestamps
    end
    add_index :larvata_timesheet_calendars, :name, unique: true
  end
end
