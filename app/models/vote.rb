# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote       :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
class Vote < ApplicationRecord
    validates :vote, presence: true
    validates :user_id, presence: true
    belongs_to :short_votes, primary_key: :id, foreign_key: :user_id, class_name: 'ShortenedUrl'
end
