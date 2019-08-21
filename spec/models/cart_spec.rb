require 'rails_helper'

describe Cart do
  it "can initialize with no contents" do
    cart = Cart.new(nil)
    expect(cart.contents).to eq({})
  end

  it "can initialize with contents" do
    cart = Cart.new({"4"=>"2", "7"=>"1"})
    expect(cart.contents).to eq({"4"=>"2", "7"=>"1"})
  end

  it "can report total items in cart" do
    cart = Cart.new(nil)
    expect(cart.total_items).to eq(0)

    cart = Cart.new({"4"=>"2", "7"=>"1"})
    expect(cart.total_items).to eq(3)
  end
end
