class Absences < ActiveRecord::Migration
  def up

    create_table :absences do |t|
      t.column :title, :string
    end

    create_table :doctor_absences do |t|
      t.column :absence_date, :datetime
      t.references :absence
      t.references :doctor
    end

  end

  def down

    drop_table :doctor_absences
    drop_table :absences

  end
end
