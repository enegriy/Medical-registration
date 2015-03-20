class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.column :title, :string
      t.column :controller, :string
      t.column :action, :string
    end
  end
end
