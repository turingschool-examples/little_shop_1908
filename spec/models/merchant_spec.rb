require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  describe "instance methods" do
    it "can check if it has item orders" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      expect(bike_shop.has_item_orders?).to eq(false)

      cart = Cart.new({})
      cart.add_item(chain.id)
      order = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250)
      order.generate_item_orders(cart)


      expect(bike_shop.has_item_orders?).to eq(true)
    end
  end
end
