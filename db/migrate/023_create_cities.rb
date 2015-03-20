class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.column :name, :string, :limit=>60
      t.references :region
    end
  end

  def down
    drop_table :cities
  end
end
