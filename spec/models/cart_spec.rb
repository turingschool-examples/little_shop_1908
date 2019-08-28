require 'rails_helper'
require './app/models/cart'

describe Cart, type: :model do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @cart = Cart.new({@chain.id.to_s => 1})
  end

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({
        1 => 2,
        2 => 3
      })
      expect(cart.total_count).to eq(5)
    end
  end

  it "test add item" do
    cart = Cart.new(nil)
    expect(cart.contents).to eq({})

    cart.add_item(@chain)
    expect(cart.contents).to eq({"#{@chain}" => 1})
  end

  it "test subtract item" do
    cart = Cart.new(nil)
    cart.add_item(@chain)

    cart.subtract_item(@chain)
    expect(cart.contents).to eq({})
  end

  it "test quantity_of item" do
    @cart.add_item(@chain)

    expect(@cart.quantity_of(@chain)).to eq(1)
  end

  it "test available inventory" do
    expect(@cart.available_inventory?(@chain)).to eq(true)
  end

  it "test subtotal" do
    @cart.add_item(@chain)

    expect(@cart.subtotal(@chain)).to eq(50)
  end

  it "test grand total" do
    expect(@cart.grand_total).to eq(50)
  end

  it "test items" do
    expect(@cart.items).to eq([@chain])
  end

end
