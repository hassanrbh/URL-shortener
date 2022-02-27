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
    validates :user_id, presence: true
    scope :premium_users, -> {  joins(:submitter).select("shortened_urls.*, users.*").where("users.premium = ?", true).uniq }
    scope :check_users_nil, -> { where.not(id: nil) }
    validate(:no_spamming, :nonpremium_max)
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
    def self.create_shortened_url(user,long_url)
        ShortenedUrl.create!(
            user_id: user.id,
            long_url: long_url 
        )
    end
    def random_code
        loop do 
            token = SecureRandom.urlsafe_base64(16)
            self.short_url = token
            break;
        end
    end

    has_many :votes , primary_key: :id, foreign_key: :user_id, class_name: 'Vote'

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
    def track_visitors(visitor_id)

    end
    # Many to many relationship
    has_many :taggings,
        class_name: 'Tagging',
        primary_key: :id,
        foreign_key: :shortener_id
    # Tag topics Relation
    has_many :tag_topics, through: :taggings, source: :tag_topic

    # Non Spamming
    def no_spamming
        last_minute = ShortenedUrl
            .where("created_at >= ?", 1.minute.ago)
            .count
        errors[:max] << "maximum is 5 urls in 1 minute" if last_minute >= 5
    end
    # Non premium max
    def nonpremium_max
        return if User.find(self.user_id).premium
        # Check the users that have premium enabled
        numbers_of_urls = ShortenedUrl
            .where(user_id: user_id)
            .length
        if numbers_of_urls >= 5
            errors[:only] <<  'premium members can create more than 5 short urls'
        end 
    end
    
    # ! Pruning Stale URLs: we are going to remove URLs from our database that hase not been pruned or visited in a long period of time

    def self.prune(n)
        # calculate the url visited urls
        visited_urls = Visit
            .where(shortener_id: :id)
            .length
        # delete the shortened url that has not been visited in the last (n) minute
        ShortenedUrl.content_columns.each do |url|
            # check if each url visits has already been visited in the last (n) minute
            if url.visits.last.created_at <= n.minute
                ShortenedUrl.find_by(id: url.id).destroy
            elsif url.visits.last.created_at >= n.minute && visited_urls == 0
                ShortenedUrl.find_by(id: url.id).destroy
            end
        end
    end
    def self.prune(n)
        ShortenedUrl
            .joins(:submitter) # inner join for all the submitters
            .joins("LEFT JOIN visits ON visits.shortener_id = shortened_urls.id") # left join for visits
            .where(
                "shortened_urls.id IN (
                    SELECT shortened_urls.id
                    FROM shortened_urls
                    JOIN visits
                    ON visits.shortener_id = shortened_urls.id
                    GROUP BY shortener_urls.id
                    HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
                )"
            )
    end
end

