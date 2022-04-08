require 'reform/form/validation/unique_validator'
module User::Contract
    class UpdatePassword < Reform::Form
        property :password
        property :password_confirmation,virtual: true

        validates :password, presence: true, confirmation: true ,length: { within: 4..255 }
        validates :password_confirmation, presence: true,length: { within: 4..255 }
    end
end