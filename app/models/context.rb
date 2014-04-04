class Context < ActiveRecord::Base
  belongs_to :bbs_thread, :touch => true
  belongs_to :user

  #default_scope -> { order(:id) }

  validates :bbs_thread_id, presence: true
  validates :user_id,       presence: true
  validates :description,   presence: true
end
