# == Schema Information
#
# Table name: scrims
#
#  id         :integer          not null, primary key
#  team1_id   :integer
#  team2_id   :integer
#  match_time :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  approved   :boolean          default(FALSE)
#  server     :string(255)
#

class Scrim < ActiveRecord::Base
  attr_accessible :match_time, :team1_id, :team2_id, :server
  
  belongs_to :requester, foreign_key: :team1_id, :class_name => "Team"
  belongs_to :requestee, foreign_key: :team2_id, :class_name => "Team"
end
