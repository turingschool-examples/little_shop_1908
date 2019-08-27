class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :order_key, default: (rand(10 ** 10).to_s.rjust(10, "0"))

      t.timestamps
    end
  end
end
