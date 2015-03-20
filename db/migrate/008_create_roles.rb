class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.column :name, :string
    end
  end
end
