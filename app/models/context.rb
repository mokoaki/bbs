class Context < ActiveRecord::Base
  belongs_to :bbs_thread #, :touch => true #自動でtouchしてもbefore_saveとかコールバックが動かないらしいので自分でupdateする
  belongs_to :user

  validates :bbs_thread_id, presence: true
  validates :user_id,       presence: true
  validates :user_name,     presence: true
  validates :description,   presence: true
  validates :no,            presence: true
end
