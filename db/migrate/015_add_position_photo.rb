class AddPositionPhoto < ActiveRecord::Migration
  def up
    add_column :doctors, :position_photo, :string, :limit=>1
  end

  def down
    remove_column :doctors, :position_photo
  end
end
