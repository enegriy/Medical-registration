class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.column :visit_date, :datetime
      t.references :doctor
      t.references :user
    end
  end
end
