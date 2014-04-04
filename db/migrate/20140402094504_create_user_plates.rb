class CreateUserPlates < ActiveRecord::Migration
  def change
    create_table :user_plates do |t|
      t.string  :user_id
      t.string  :plate_id
    end

    add_index :user_plates, :user_id
    add_index :user_plates, :plate_id
    add_index :user_plates, [:user_id, :plate_id], unique: true
  end
end
