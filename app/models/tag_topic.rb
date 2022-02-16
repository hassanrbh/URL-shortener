# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  tag_topic  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord
    validates :tag_topic, presence: true, uniqueness: true

    # Shortened Url relaton
    has_many :taggings,
        class_name: 'Tagging',
        primary_key: :id,
        foreign_key: :topic_id
    # Many to many relationship
    has_many :shortenedurls, through: :taggings, source: :shortenedurl

    
    def self.popular_links
        # return the 5 most visited url
        ShortenedUrl.joins(:visits)
            .group(:short_url,:long_url)
            .order('COUNT(visits.id) DESC')
            .select('long_url, short_url, COUNT(visits.id) AS number_clicks')
            .limit(5)
    end
end
