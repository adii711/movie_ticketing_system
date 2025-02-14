class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password
      t.string :phone_number
      t.string :address
      t.string :card_number
      t.string :expirate_date
      t.string :cvv

      t.timestamps
    end
  end
end
