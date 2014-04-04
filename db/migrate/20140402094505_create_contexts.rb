class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.integer  :user_id
      t.integer  :bbs_thread_id
      t.integer  :no
      t.text     :description

      t.datetime :created_at
    end

    add_index :contexts, :bbs_thread_id
    add_index :contexts, :no
    add_index :contexts, [:bbs_thread_id, :no], unique: true
  end
end
