class AddProgoptionsOptionUniqIndex < ActiveRecord::Migration
  def up
    add_index :prog_options, :option, :unique => true
  end

  def down
    remove_index :prog_options, :option
  end
end
