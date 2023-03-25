class User < ApplicationRecord
    # to incorporate password enscryption with bcrypt
    has_secure_password
    has_many :recipes
    validates :username, presence: true, uniqueness: true
end
