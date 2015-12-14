class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.references :book, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
