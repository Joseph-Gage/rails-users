class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /@/},
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       length: { minimum: 8, maximum: 50 }
  has_secure_password

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
