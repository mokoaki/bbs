class Context < ActiveRecord::Base
  belongs_to :bbs_thread #, :touch => true #������touch���Ă�before_save�Ƃ��R�[���o�b�N�������Ȃ��炵���̂Ŏ�����update����
  belongs_to :user

  validates :bbs_thread_id, presence: true
  validates :user_id,       presence: true
  validates :user_name,     presence: true
  validates :description,   presence: true
  validates :no,            presence: true
end
