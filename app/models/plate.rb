class Plate < ActiveRecord::Base
  #has_many :plate_users #, dependent: :destroy
  #has_many :users, :through => :plate_users, source: :users

  has_many :bbs_threads, dependent: :destroy

  validates :name, presence: true
end
