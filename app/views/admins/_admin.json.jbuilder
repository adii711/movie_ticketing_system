json.extract! admin, :id, :username, :name, :email, :password, :created_at, :updated_at
json.url admin_url(admin, format: :json)
