class DeleteColumnLocalities < ActiveRecord::Migration
  def up
  	remove_column :doctors, :localities_id
  end

  def down
  	add_column :doctors, :localities_id, :integer
  end
end
