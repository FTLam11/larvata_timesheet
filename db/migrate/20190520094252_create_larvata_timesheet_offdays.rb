class CreateLarvataTimesheetOffdays < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_timesheet_offdays, id: false do |t|
      t.string :date_id, null: false
      t.boolean :is_off, null: false

      t.timestamps

      t.index :date_id, unique: true
    end
  end
end
