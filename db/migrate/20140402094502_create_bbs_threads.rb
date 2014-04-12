class CreateBbsThreads < ActiveRecord::Migration
  def change
    create_table :bbs_threads do |t|
      t.belongs_to :plate
      t.string     :name
      t.integer    :contexts_count
      t.datetime   :updated_at
    end

    add_index :bbs_threads, :plate_id
  end
end
