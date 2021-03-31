class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :image_path

      t.timestamps
    end
  end
end
