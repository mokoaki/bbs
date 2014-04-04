class UserPlate < ActiveRecord::Base
  #belongs_to :user
  belongs_to :plate

  validates :user_id,  presence: true
  validates :plate_id, presence: true
end
