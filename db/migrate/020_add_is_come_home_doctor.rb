class AddIsComeHomeDoctor < ActiveRecord::Migration
  def up
    add_column :doctors, :is_come_home, :boolean
  end

  def down
    remove_column :doctors, :is_come_home
  end
end
