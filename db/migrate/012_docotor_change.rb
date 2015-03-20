class DocotorChange < ActiveRecord::Migration
  def up
    add_column :doctors, :work_phone, :string, :limit=>20
  end

  def down
    remove_column :doctors, :work_phone
  end
end
