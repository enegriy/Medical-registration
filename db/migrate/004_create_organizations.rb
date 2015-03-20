class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.column :name, :string, :limit=>40
      t.column :address, :string
      t.column :photo_path, :string
    end
  end
end
