class Context < ActiveRecord::Base
  belongs_to :bbs_thread, :touch => true
  belongs_to :user

  default_scope -> { includes(:user).order(:id) }

  validates :bbs_thread_id, presence: true
  validates :user_id,       presence: true
  validates :description,   presence: true
  validates :no,            presence: true
end
