class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.belongs_to :user
      t.string     :user_name
      t.belongs_to :plate
      t.belongs_to :bbs_thread
      t.integer    :no
      t.text       :description
      t.boolean    :delete_flg, default: false

      t.datetime   :created_at
    end

    add_index :contexts, :plate_id
    add_index :contexts, :bbs_thread_id
    add_index :contexts, :no
    add_index :contexts, [:bbs_thread_id, :no], unique: true
  end
end
