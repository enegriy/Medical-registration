class ProgOptions < ActiveRecord::Migration
  def up
    create_table :prog_options, :id=>false do |t|
      t.column :option, :string, :limit=>60
      t.column :value, :string, :limit=>100
    end
  end

  def down
    drop_table :prog_options
  end
end
