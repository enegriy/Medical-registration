class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
		  t.column :login, :string, :null=>false
		  t.column :password, :string, :null=>false
		  t.column :phone, :string
		  t.timestamps
      t.references :role
      t.references :doctor
    end
  end
end
