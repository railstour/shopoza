class AddPriceToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :unit_price, :integer
  end
end
