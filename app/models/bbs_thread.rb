class BbsThread < ActiveRecord::Base
  default_scope -> { order(updated_at: :desc) }

  default_scope -> { select(:id, :plate_id, :name, :contexts_count) }

  has_many   :contexts, dependent: :delete_all
  belongs_to :plate

  validates :plate_id, presence: true
  validates :name,     presence: true
end
