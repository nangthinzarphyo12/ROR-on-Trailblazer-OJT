class Post < ApplicationRecord
    belongs_to :author, class_name: "User", foreign_key: "created_by"
    belongs_to :user, foreign_key: "created_by"

    # validates :title, presence: true ,length: { maximum: 255 }
    # validates :description, presence: true ,length: { maximum: 1000 }
    # validates :public_flag, presence: true

    def self.to_csv
        attributes = %w{title description public_flag created_by}
        CSV.generate(headers: true) do |csv|
            csv << attributes
            all.each do |post|
                csv << post.attributes.values_at(*attributes)
            end
        end
    end
    
end
