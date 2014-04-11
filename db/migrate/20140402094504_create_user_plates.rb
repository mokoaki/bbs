class CreateUserPlates < ActiveRecord::Migration
  def change
    #create_table :user_plates do |t|
    create_table(:user_plates, id: false) do |t|
      t.belongs_to  :user
      t.belongs_to  :plate
    end

    add_index :user_plates, :user_id
    add_index :user_plates, :plate_id
    add_index :user_plates, [:user_id, :plate_id], unique: true
  end
end
