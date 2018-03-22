class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /@/},
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       length: { minimum: 8, maximum: 50 }
  has_secure_password
end
