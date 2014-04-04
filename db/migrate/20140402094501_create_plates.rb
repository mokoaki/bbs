class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.string  :name
    end
  end
end
