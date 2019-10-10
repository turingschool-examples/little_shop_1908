require 'rails_helper'

RSpec.describe Cart do
  describe "methods" do
    it "#total_count can calculate item in cart" do
      cart = Cart.new({"1" => 2, "2" => 3})

      expect(cart.total_count).to eq(5)
    end

    it "#add_item can add item to cart" do
      cart = Cart.new({"1" => 2, "2" => 3})
      cart.add_item(2)
      expect(cart.total_count).to eq(6)
    end
  end
end
