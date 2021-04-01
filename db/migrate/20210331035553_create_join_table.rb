class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :item_details do |t|
      t.belongs_to :item
      t.belongs_to :image
      t.belongs_to :bulleting
    end
  end
end
