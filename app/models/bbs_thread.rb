class BbsThread < ActiveRecord::Base
  default_scope -> { order(updated_at: :desc) }

  has_many   :contexts
  belongs_to :plate

  validates :plate_id, presence: true
  validates :name,     presence: true
end
