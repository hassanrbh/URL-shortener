# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote       :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Vote < ApplicationRecord

end
