require 'reform/form/validation/unique_validator'
module User::Contract
    class Update < Reform::Form
        property :name
        property :email
        property :phone
        property :role

        validates :name, presence: true ,length: { maximum: 255 }
        validates :email, presence: true ,length: { maximum: 255 } ,format: { with: URI::MailTo::EMAIL_REGEXP }, unique: true
        validates :phone, length: { maximum: 255 }
        validates :role, presence: true
    end
end