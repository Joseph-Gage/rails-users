json.extract! user, :id, :name, :email, :password_digest, :remember_digest, :admin, :activation_digest, :activated, :activated_at, :reset_digest, :reset_sent_at, :created_at, :updated_at
json.url user_url(user, format: :json)
