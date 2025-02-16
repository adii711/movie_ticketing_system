class FixcolumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :shows, :ticket_price, :price
  end
end
