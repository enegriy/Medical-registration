class CreateBlacklists < ActiveRecord::Migration
  def up
    create_table :blacklists do |t|
      t.references :doctor
      t.references :user
      t.column :lock_to, :date
    end
  end

  def down
    drop_table :blacklists
  end
end
