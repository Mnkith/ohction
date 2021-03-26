class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :starting_price
      t.time :duration
      t.string :condition
      t.integer :shipping

      t.timestamps
    end
  end
end
