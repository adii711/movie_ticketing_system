class AvailableSeats < ActiveRecord::Migration[8.0]
  def change
    add_column :shows, :available_seats, :integer
    
  end
end
