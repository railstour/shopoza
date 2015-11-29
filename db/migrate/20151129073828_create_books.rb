class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :quantity
      t.text :summary
      t.integer :price
    end
  end
end
