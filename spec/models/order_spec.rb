require 'rails_helper'

describe Order do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @order = Order.create(nil)
  end

  it "test grand total" do
    expect(@order.grand_total).to eq(0)
  end

  it "test order item subtotal" do
    order = Order.create({name: "Leiya Kelly", address: "123 ILiveAtTuring Ave", city: "Denver", state: "CO", zip: 80216})
    order.order_items.create({quantity: 1, price: 50, name: "Kickstand", merchant: @bike_shop.name, subtotal: 50, merchant_id: @bike_shop.id})
    expect(order.grand_total).to eq(50.0)
  end
end
