require 'reform/form/validation/unique_validator'
module User::Contract
    class Create < Reform::Form
        property :name
        property :email
        property :password
        property :password_confirmation,virtual: true
        property :phone
        property :role

        validates :name, presence: true ,length: { maximum: 255 }
        validates :email, presence: true ,length: { maximum: 255 } ,format: { with: URI::MailTo::EMAIL_REGEXP }, unique: true
        validates :password, presence: true, confirmation: true ,length: { within: 4..255 }
        validates :password_confirmation, presence: true,length: { within: 4..255 }
        validates :phone, length: { maximum: 255 }
        validates :role, presence: true

    end
end