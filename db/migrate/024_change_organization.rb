class ChangeOrganization < ActiveRecord::Migration
  def up
    drop_table :organizations

    create_table :organizations do |t|
      t.column :name, :string, :limit=>40
      t.column :street, :string, :limit=>50
      t.column :number, :int
      t.references :city
    end
  end

  def down
    drop_table :organizations
  end
end
