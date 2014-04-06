class User < ActiveRecord::Base
  before_save :before_save_action
  before_create :create_remember_token

  has_many :user_plates, dependent: :destroy
  has_many :plates, :through => :user_plates, source: :plate

  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    #リメンバートークン この値はログインする度に変わる
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  def before_save_action
    self.email.downcase!
    self.admin = true if self.super_admin?
  end
end
