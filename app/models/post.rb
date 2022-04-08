class Post < ApplicationRecord
    belongs_to :user, foreign_key: "created_by"

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
