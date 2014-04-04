class User < ActiveRecord::Base
  #User.save�O�Ƀ��A�h����������
  before_save { self.email.downcase! }

  #User.create�O�Ƀ������o�[�g�[�N�������l��ۑ�����p��
  before_create :create_remember_token

  has_many :user_plates, dependent: :destroy
  has_many :plates, :through => :user_plates, source: :plate

  #�o���f�[�g�`�F�b�N�����Ă���邵�A�G���[���b�Z�[�W������Ă����
  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  #BCrypt�֌W�A���A�h�Í����A���̔F�؂̂����������Ɏ������Ă���邠�肪�����z
  has_secure_password

  #User�Ŏn�܂��Ă���̂̓N���X���\�b�h�B�C���X�^���X���\�b�h�ł͂Ȃ�
  def User.new_remember_token
    #�����_��������
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    #�Í���
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    #�������o�[�g�[�N�������l�@���̒l�̓��O�C�����邽�тɕς��
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
