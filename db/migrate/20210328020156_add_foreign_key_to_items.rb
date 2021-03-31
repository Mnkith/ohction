class AddForeignKeyToItems < ActiveRecord::Migration[6.1]
  def change
    # add_column :items, :seller_id, :integer
    # add_column :items, :buyer_id, :integer, default: 0
    # add_foreign_key :items, :users, column: :seller_id, null: true
    # add_foreign_key :items, :users, column: :buyer_id, null: true
    add_reference :items, :buyer, foreign_key: { to_table: :users }
    add_reference :items, :seller, foreign_key: { to_table: :users }
  end
end
