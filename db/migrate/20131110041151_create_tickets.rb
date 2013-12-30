class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user
      t.references :event, null: false
      t.string :comment
      t.timestamps
    end

    add_index :tickets, [:user_id, :event_id], unique: true
    add_index :tickets, [:event_id, :user_id], unique: true
  end
end
