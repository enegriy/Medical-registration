class CreateDayofweeks < ActiveRecord::Migration
  def change
    create_table :dayofweeks do |t|
      t.column :name, :string
    end
  end
end
