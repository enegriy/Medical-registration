class CreateDaytypes < ActiveRecord::Migration
  def change
    create_table :daytypes do |t|
      t.column :name, :string
    end
  end
end
