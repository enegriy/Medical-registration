class AddExperienceDoctor < ActiveRecord::Migration
  def up
    add_column :doctors, :experience, :integer
  end

  def down
    remove_column :doctors, :experience
  end
end
