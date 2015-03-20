class AddIssendvisitsDoctor < ActiveRecord::Migration
  def up
    add_column :doctors, :is_send_visits, :boolean
  end

  def down
    remove_column :doctors, :is_send_visits
  end
end
