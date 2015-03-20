class CreateRegions < ActiveRecord::Migration
  def up
    create_table :regions do |t|
      t.column :name, :string, :limit=>60
    end
  end

  def down
    drop_table :regions
  end
end
