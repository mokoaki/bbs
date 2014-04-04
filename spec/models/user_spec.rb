require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build(:valid_user)
  end

  subject { @user }

  describe 'メソッドチェック' do
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:admin) }
    it { should respond_to(:super_admin) }

    context 'クラスメソッドチェック' do
      let(:remember_token) { User.new_remember_token }

      it { expect(remember_token).not_to be_blank }
      it { expect(User.encrypt(remember_token)).not_to be_blank }
    end

    context 'プライベートメソッドチェック' do
      let(:remember_token) { User.new_remember_token }

      its(:remember_token) { should_not eq User.encrypt(remember_token) }
    end
  end

  context 'デフォルトユーザチェック' do
    it { should be_valid }
  end

  describe 'バリデーションチェック' do
    describe '名前' do
      it '空白' do
        @user.name = ' '
        should_not be_valid

        @user.name = ''
        should_not be_valid
      end

      it '長い' do
        @user.name = 'a' * 32
        should be_valid

        @user.name = 'a' * 33
        should_not be_valid
      end
    end

    describe 'パスワード' do
      it '空白' do
        @user.password = ' '
        @user.password_confirmation = ' '
        should_not be_valid

        @user.password = ''
        @user.password_confirmation = ''
        should_not be_valid
      end

      it '再入力不一致' do
        @user.password_confirmation = 'mismatch'
        should_not be_valid
      end

      it '短い' do
        @user.password              = 'a' * 6
        @user.password_confirmation = 'a' * 6
        should be_valid

        @user.password              = 'a' * 5
        @user.password_confirmation = 'a' * 5
        should_not be_valid
      end
    end

    describe 'Eメール' do
      it '空白' do
        @user.email = ' '
        should_not be_valid

        @user.email = ''
        should_not be_valid
      end

      describe 'パターンチェック' do
        it 'OKパターン' do
          addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]

          addresses.each do |valid_address|
            @user.email = valid_address

            should be_valid
          end
        end

        it 'NGパターン' do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo. example.user@foo foo@bar_baz.com foo@bar+baz.com]

          addresses.each do |invalid_address|
            @user.email = invalid_address

            should_not be_valid
          end
        end
      end

      it '重複' do
        same_email_user = @user.dup
        same_email_user.save

        should_not be_valid
      end

      it '大文字にしても重複チェック対象' do
        same_email_user = @user.dup
        same_email_user.email = @user.email.upcase
        same_email_user.save

        should_not be_valid
      end
    end
  end

  describe '認証チェック'do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    it 'OKパターン' do
      should eq found_user.authenticate(@user.password)
    end

    describe 'NGパターン' do
      let(:invalid_password_user) { found_user.authenticate("invalid") }

      it { should_not eq invalid_password_user }
      it { expect(invalid_password_user).to be_false }
    end
  end

  describe 'Eメール強制小文字化チェック' do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe 'Eメール強制小文字化チェック' do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe 'save時にremember_tokenを保存する' do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe '権限チェック' do
    context 'デフォルトユーザ権限チェック' do
      it { should_not be_admin }
      it { should_not be_super_admin }
    end

    describe '権限変更チェック' do
      before do
        @user.save!
      end

      it 'admin権限' do
        @user.toggle!(:admin)
        should be_admin

        @user.toggle!(:admin)
        should_not be_admin
      end

      it 'super_admin権限' do
        @user.toggle!(:super_admin)
        should be_super_admin

        @user.toggle!(:super_admin)
        should_not be_super_admin
      end
    end
  end
end
