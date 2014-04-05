class Plate < ActiveRecord::Base
  has_many :bbs_threads, dependent: :destroy
  has_many :user_plates, dependent: :destroy

  validates :name, presence: true, :uniqueness => true
end
