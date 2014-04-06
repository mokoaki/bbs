class CreateBbsThreads < ActiveRecord::Migration
  def change
    create_table :bbs_threads do |t|
      t.integer :plate_id
      t.string  :name

      t.datetime :updated_at
    end

    add_index :bbs_threads, :plate_id
  end
end
