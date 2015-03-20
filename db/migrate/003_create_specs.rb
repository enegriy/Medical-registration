class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.column :name, :string
    end
  end
end
