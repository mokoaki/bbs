class AddPassToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pass, :string
  end
end
