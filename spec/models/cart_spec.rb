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

  it "can report quantity of an item" do
    cart = Cart.new({"4"=>"2", "7"=>"1"})
    expect(cart.quantity_of(4)).to eq(2)
    expect(cart.quantity_of(7)).to eq(1)
  end

  it "can add items to contents" do
    cart = Cart.new(nil)
    cart.add_item(7)
    expect(cart.contents).to eq({"7"=>1})
  end
end
