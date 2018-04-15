class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :type
      t.integer :quantity
      t.integer :cost
      t.integer :price

      t.timestamps
    end
  end
end
