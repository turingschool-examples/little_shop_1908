class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :username
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
