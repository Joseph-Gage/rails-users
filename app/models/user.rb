class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /@/},
                    uniqueness: { case_sensitive: false }
end
