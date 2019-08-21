require 'rails_helper'

RSpec.describe Cart do

  subject { Cart.new({"4" => "3", "9" => "100"}) }

  it "can initialize with no contents" do
    cart = Cart.new(nil)

    expect(cart.contents).to eq({})
  end

  it "can initialize with contents" do
    expect(subject.contents).to eq({"4" => "3", "9" => "100"})
  end

  it "can report the quantity of a item" do
    expect(subject.quantity_of(4)).to eq(3)
  end

  it "can add a new item" do
    subject.add_item(5)
    expect(subject.quantity_of(5)).to eq(1)
  end
end
