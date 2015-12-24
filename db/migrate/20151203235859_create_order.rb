class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :checkout_id, index: true
      t.timestamps
    end
  end
end
