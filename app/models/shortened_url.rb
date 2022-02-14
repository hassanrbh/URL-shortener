# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true, uniqueness: true
    validates :user_id, presence: true, uniqueness: true
    validate(:random_code)

    def random_code
        loop do 
            token = SecureRandom.urlsafe_base64(16)
            self.short_url = token
            break;
        end
    end

    belongs_to(
        :submitter,
        class_name: 'User',
        primary_key: :id,
        foreign_key: :user_id
    )
end
