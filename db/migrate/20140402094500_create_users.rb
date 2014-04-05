class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :name
      t.string  :password_digest
      t.string  :remember_token

      #管理者
      #板の作成・削除
      #全てのユーザへの、各板への所属権与奪
      t.boolean :super_admin, default: false

      #板管理者
      #全てのユーザへの、自分の所属している板への所属権与奪
      t.boolean :admin, default: false

      #true  : ログイン可能
      #false : ログイン不可能
      t.boolean :enable, default: true

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_token
  end
end
