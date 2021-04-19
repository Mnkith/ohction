class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.float :starting_price, default: 0
      t.float :minimum_price, default: 0
      t.float :current_price, default: 0
      t.datetime :start_time
      t.datetime :end_time
      t.float :shipping, default: 0

      t.timestamps
    end
  end
end
