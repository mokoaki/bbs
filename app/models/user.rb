class User < ActiveRecord::Base
  #User.save前にメアドを小文字化
  before_save { self.email.downcase! }

  #User.create前にリメンバートークン初期値を保存する用意
  before_create :create_remember_token

  has_many :user_plates, dependent: :destroy
  has_many :plates, :through => :user_plates, source: :plate

  #バリデートチェックもしてくれるし、エラーメッセージも作ってくれる
  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  #BCrypt関係、メアド暗号化、その認証のあたりを勝手に実装してくれるありがたい奴
  has_secure_password

  #Userで始まっているのはクラスメソッド。インスタンスメソッドではない
  def User.new_remember_token
    #ランダム文字列
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    #暗号化
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    #リメンバートークン初期値　この値はログインするたびに変わる
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
