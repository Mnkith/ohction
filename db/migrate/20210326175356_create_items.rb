class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :starting_price, default: 0
      t.integer :minimum_price, default: 0
      t.integer :current_price, default: 0
      t.datetime :start_time
      t.datetime :end_time
      t.integer :shipping, default: 0

      t.timestamps
    end
  end
end
