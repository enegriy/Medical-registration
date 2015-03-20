class CreateMenuLinkRoles < ActiveRecord::Migration
  def change
    create_table :menu_link_roles do |t|
      t.references :role
      t.references :menu
    end
  end
end
