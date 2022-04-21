class User < ApplicationRecord
    has_secure_password

    # validates :name, presence: true ,length: { maximum: 255 }
    # validates :email, presence: true ,length: { maximum: 255 } ,format: { with: URI::MailTo::EMAIL_REGEXP }
    # validates :password, presence: true, confirmation: true ,length: { within: 4..255 }
    # validates :password_confirmation, presence: true,length: { within: 4..255 }
    # validates :phone, length: { maximum: 12 }
    # validates :role, presence: true
end
