class AddVerificationToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :verification, :string
  end
end
