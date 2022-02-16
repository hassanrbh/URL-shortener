# == Schema Information
#
# Table name: taggings
#
#  id           :bigint           not null, primary key
#  topic_id     :integer          not null
#  shortener_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Tagging < ApplicationRecord
    validates :topic_id, presence: true
    validates :shortener_id, presence: true, uniqueness: true

    # ShortenedUrl relationship
    belongs_to :shortenedurl,
        class_name: 'ShortenedUrl',
        primary_key: :id,
        foreign_key: :shortener_id
    # Tag topic relationship
    belongs_to :tag_topic,
        class_name: 'TagTopic',
        primary_key: :id,
        foreign_key: :topic_id
end
