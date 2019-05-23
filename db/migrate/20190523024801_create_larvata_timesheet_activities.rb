class CreateLarvataTimesheetActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_timesheet_activities do |t|
      t.references :category, foreign_key: { to_table: :larvata_timesheet_activities }
      t.integer :rank, null: false
      t.string :name, null: false
      t.boolean :enabled, null: false

      t.timestamps
    end
  end
end
