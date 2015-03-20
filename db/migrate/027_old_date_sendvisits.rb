class OldDateSendvisits < ActiveRecord::Migration
  def up
    add_column :doctors, :old_date_sendvisits, :date
  end

  def down
    remove_column :doctors, :old_date_sendvisits
  end
end
