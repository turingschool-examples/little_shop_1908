require 'rails_helper'

describe Order do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationships' do
    it { should have_many :item_orders }
    it { should have_many :items }
  end

  describe 'instance methods' do
    it '#create_item_orders' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      light = bike_shop.items.create(name: "Lights", description: "So bright!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      order = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      cart = Cart.new({"#{light.id}" => "1"})

      expect(ItemOrder.last).to be(nil)

      order.create_item_orders(cart)
      item_order = ItemOrder.last

      expect(item_order.order_id).to eq(order.id)
      expect(item_order.item_id).to eq(light.id)
      expect(item_order.quantity).to eq(1)
      expect(item_order.total_cost).to eq(light.price)
    end
  end
end
