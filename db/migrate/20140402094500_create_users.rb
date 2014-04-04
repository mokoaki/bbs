class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :name
      t.string  :password_digest
      t.string  :remember_token

      t.boolean :super_admin, default: false
      t.boolean :admin,       default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_token
  end
end
