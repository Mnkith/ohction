class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.float :amount, default: 0
      t.belongs_to :user
      t.belongs_to :item
      t.timestamps
    end
  end
end
