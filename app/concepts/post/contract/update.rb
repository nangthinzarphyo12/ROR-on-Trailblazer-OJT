require 'reform/form/validation/unique_validator'
module Post::Contract
    class Update < Reform::Form
        property :title
        property :description
        property :public_flag
        property :updated_by

        validates :title, presence: true ,length: { maximum: 255 }
        validates :description, presence: true ,length: { maximum: 1000 }
        validates :public_flag, presence: true
        validates :updated_by, presence: true
    end
end