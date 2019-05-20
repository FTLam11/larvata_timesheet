class CreateLarvataTimesheetOffdays < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_timesheet_offdays, id: false, primary_key: :date_id do |t|
      t.string :date_id
      t.boolean :is_off, default: true

      t.timestamps
    end
  end
end
