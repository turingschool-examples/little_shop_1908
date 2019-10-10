require 'rails_helper'

RSpec.describe Cart do
  describe "methods" do
    it "#total_count can calculate item in cart" do
      cart = Cart.new({"1" => 2, "2" => 3})

      expect(cart.total_count).to eq(5)
    end

    it "#add_item can add item to cart" do
      cart = Cart.new({"1" => 2, "2" => 3})
      cart.add_item("2")
      expect(cart.total_count).to eq(6)

      cart = Cart.new({})
      cart.add_item("2")

      expect(cart.total_count).to eq(1)
    end

    it "#contents can read the contents of the cart" do
      cart = Cart.new({"1" => 2, "2" => 3})
      expected_contents = {"1" => 2, "2" => 3}

      expect(cart.contents).to eq(expected_contents)
    end

    it "#count_of can calculate the count of an item by its id" do
      cart = Cart.new({"1" => 2, "2" => 3})
      expect(cart.count_of("2")).to eq(3)

      cart.add_item("2")
      expect(cart.count_of("2")).to eq(4)
    end
  end
end
