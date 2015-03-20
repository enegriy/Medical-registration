class ChangeOrganizationName < ActiveRecord::Migration
  def up
	change_column(:organizations, :name, :string, :limit => 100)
  end

  def down
	change_column(:organizations, :name, :string, :limit => 40)
  end
end
