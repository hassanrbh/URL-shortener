# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true, uniqueness: true
    validates :user_id, presence: true, uniqueness: true
    validate(:random_code)
    def num_clicks
        ShortenedUrl.count        
    end
    def num_uniques
        ShortenedUrl.select(:user_id).distinct.count
    end
    def num_recent_uniques
        ShortenedUrl.where("created_at <= ?", 10.minutes.ago)
    end

    def random_code
        loop do 
            token = SecureRandom.urlsafe_base64(16)
            self.short_url = token
            break;
        end
    end

    belongs_to :submitter,
        primary_key: :id,
        class_name: 'User',
        foreign_key: :user_id

    has_many :visits,
        primary_key: :id,
        class_name: 'Visit',
        foreign_key: :shortener_id
    
    has_many(
        :visitors,
        through: :visits,
        source: :visitor
    )
end
