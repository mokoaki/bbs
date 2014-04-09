require 'spec_helper'

describe User do
  let(:valid_user) { FactoryGirl.build(:valid_user) }

  subject { valid_user }

  describe 'メソッドチェック' do
    it { expect respond_to(:id) }
    it { expect respond_to(:email) }
    it { expect respond_to(:name) }
    it { expect respond_to(:password_digest) }
    it { expect respond_to(:password) }
    it { expect respond_to(:password_confirmation) }
    it { expect respond_to(:remember_token) }
    it { expect respond_to(:super_admin) }
    it { expect respond_to(:admin) }
    it { expect respond_to(:enable) }
    it { expect respond_to(:updated_at) }
    it { expect respond_to(:created_at) }

    context 'クラスメソッドチェック' do
      let(:remember_token) { User.new_remember_token }

      it { expect(remember_token).not_to be_blank }
      it { expect(User.encrypt(remember_token)).not_to be_blank }
    end

    describe 'プライベートメソッドチェック' do
      context 'create_remember_token' do
        let(:remember_token) { User.new_remember_token }

        its(:remember_token) { should_not eq User.encrypt(remember_token) }
      end

      context 'before_save_action' do
        let(:same_user) { valid_user.dup }

        before do
          same_user.email.upcase!
          same_user.admin = false
          same_user.super_admin = true
          same_user.save
        end

         it { expect(same_user.email).to eq valid_user.email }
         it { expect(same_user.admin).to be_true }
      end
    end
  end

  context 'デフォルトユーザチェック' do
    it { should be_valid }
  end

  describe 'バリデーションチェック' do
    describe '名前' do
      it '空白' do
        valid_user.name = ' '
        should_not be_valid

        valid_user.name = ''
        should_not be_valid
      end

      it '長い' do
        valid_user.name = 'a' * 32
        should be_valid

        valid_user.name = 'a' * 33
        should_not be_valid
      end
    end

    describe 'パスワード' do
      it '空白' do
        valid_user.password = ' '
        valid_user.password_confirmation = ' '
        should_not be_valid

        valid_user.password = ''
        valid_user.password_confirmation = ''
        should_not be_valid
      end

      it '再入力不一致' do
        valid_user.password_confirmation = 'mismatch'
        should_not be_valid
      end

      it '短い' do
        valid_user.password              = 'a' * 6
        valid_user.password_confirmation = 'a' * 6
        should be_valid

        valid_user.password              = 'a' * 5
        valid_user.password_confirmation = 'a' * 5
        should_not be_valid
      end
    end

    describe 'Eメール' do
      it '空白' do
        valid_user.email = ' '
        should_not be_valid

        valid_user.email = ''
        should_not be_valid
      end

      describe 'パターンチェック' do
        it 'OKパターン' do
          addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]

          addresses.each do |valid_address|
            valid_user.email = valid_address

            should be_valid
          end
        end

        it 'NGパターン' do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo. example.user@foo foo@bar_baz.com foo@bar+baz.com]

          addresses.each do |invalid_address|
            valid_user.email = invalid_address

            should_not be_valid
          end
        end
      end

      it '重複' do
        same_email_user = valid_user.dup
        same_email_user.save

        should_not be_valid
      end

      it '大文字にしても重複チェック対象' do
        same_email_user = valid_user.dup
        same_email_user.email = valid_user.email.upcase
        same_email_user.save

        should_not be_valid
      end
    end
  end

  describe '認証チェック'do
    before { valid_user.save }
    let(:found_user) { User.find_by(email: valid_user.email) }

    it 'OKパターン' do
      should eq found_user.authenticate(valid_user.password)
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
      valid_user.email = mixed_case_email
      valid_user.save
      expect(valid_user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe 'Eメール強制小文字化チェック' do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it do
      valid_user.email = mixed_case_email
      valid_user.save
      expect(valid_user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe 'save時にremember_tokenを保存する' do
    before { valid_user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe '権限チェック' do
    context 'デフォルトユーザ権限チェック' do
      it { should_not be_admin }
      it { should_not be_super_admin }
    end

    describe '権限変更チェック' do
      before do
        valid_user.save!
      end

      it 'admin権限' do
        valid_user.toggle!(:admin)
        should be_admin

        valid_user.toggle!(:admin)
        should_not be_admin
      end

      it 'super_admin権限' do
        valid_user.toggle!(:super_admin)
        should be_super_admin

        valid_user.toggle!(:super_admin)
        should_not be_super_admin
      end
    end
  end
end
