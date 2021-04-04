class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.integer :amount, default: 0
      t.timestamps
    end
  end
end
