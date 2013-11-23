class AddEventImageToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_image, :string
  end
end
