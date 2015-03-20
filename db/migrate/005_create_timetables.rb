class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.column :time_for, :time
      t.column :time_to, :time
      t.column :time_of_visit, :integer

      t.references :daytype
      t.references :dayofweek
      t.references :doctor

      t.timestamps
    end
  end
end
