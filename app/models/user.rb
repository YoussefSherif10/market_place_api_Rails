class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, :with => /@/
    has_secure_password
end
