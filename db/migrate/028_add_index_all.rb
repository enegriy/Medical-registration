class AddIndexAll < ActiveRecord::Migration
  def up
	add_index :users, :role_id
	add_index :users, :doctor_id

	add_index :doctors, :spec_id
	add_index :doctors, :organization_id

	add_index :timetables, :daytype_id
	add_index :timetables, :dayofweek_id
	add_index :timetables, :doctor_id

	add_index :menu_link_roles, :role_id
	add_index :menu_link_roles, :menu_id

	add_index :tickets, :doctor_id
	add_index :tickets, :user_id

	add_index :cities, :region_id

	add_index :organizations, :city_id
  end

  def down
  	remove_index :users, :role_id
	remove_index :users, :doctor_id

	remove_index :doctors, :spec_id
	remove_index :doctors, :organization_id

	remove_index :timetables, :daytype_id
	remove_index :timetables, :dayofweek_id
	remove_index :timetables, :doctor_id

	remove_index :menu_link_roles, :role_id
	remove_index :menu_link_roles, :menu_id

	remove_index :tickets, :doctor_id
	remove_index :tickets, :user_id

	remove_index :cities, :region_id

	remove_index :organizations, :city_id
  end
end
