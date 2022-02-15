# == Schema Information
#
# Table name: visits
#
#  id           :bigint           not null, primary key
#  user_id      :integer          not null
#  view         :integer
#  shortener_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Visit < ApplicationRecord
    validates :user_id, presence: true, uniqueness: true
    validates :shortener_id, presence: true, uniqueness: true

    def record_visit!(user,shortener_id)
        Visit.create!(user_id: user.id ,shortener_id: shortener_id.id)
    end

    belongs_to :shortener,
        class_name: 'ShortenedUrl',
        foreign_key: :shortener_id,
        primary_key: :id
    belongs_to :visitor,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
end
