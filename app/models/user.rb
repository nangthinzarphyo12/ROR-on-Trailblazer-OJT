class User < ApplicationRecord
    has_many :posts
    has_secure_password
    validates :name, presence: true ,length: { maximum: 255 }
    validates :email, presence: true ,length: { maximum: 255 } ,format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :password, presence: true, confirmation: true ,length: { within: 4..255 }, on: :create
    validates :password, allow_blank: true,length: { within: 4..255 }, on: :update
    validates :phone, length: { maximum: 255 }
    validates :role, presence: true
end
