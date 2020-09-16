class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :postage
      t.integer :payment_method
      t.string :address
      t.string :postal_code
      t.string :name
      t.integer :total_fee
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
