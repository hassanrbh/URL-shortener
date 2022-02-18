# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  premium    :boolean          default(FALSE)
#
class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    
    has_many(
        :submitter_urls,
        class_name: 'ShortenedUrl',
        primary_key: :id,
        foreign_key: :user_id
    )

    has_many(
        :visited_urls,
        through: :submitter_urls,
        source: :visits
    )
    has_many(
        :visits,
        class_name: 'Visit',
        primary_key: :id,
        foreign_key: :user_id
    )
end
