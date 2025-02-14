json.extract! user, :id, :username, :name, :email, :password, :phone_number, :address, :card_number, :expirate_date, :cvv, :created_at, :updated_at
json.url user_url(user, format: :json)
