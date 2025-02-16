class TicketsNumber < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :number_of_tickets, :integer
  end
end
