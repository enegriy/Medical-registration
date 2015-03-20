class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.column :soname, :string
      t.column :name, :string
      t.column :second_name, :string
      t.column :birth_date, :date
      t.column :photo_path, :string
      t.column :note, :text

      t.references :spec
      t.references :organization
      t.references :localities

      t.timestamps
    end
  end
end
