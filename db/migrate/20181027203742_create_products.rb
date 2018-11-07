class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.string :picture_url
      t.integer :user_id
      t.boolean :sold

      t.timestamps
    end
  end
end
