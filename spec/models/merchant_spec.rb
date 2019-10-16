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
    it {should have_many :item_orders}
    it {should have_many :orders}
  end

  describe "instance methods" do
    it "can check if it has item orders" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      expect(bike_shop.has_item_orders?).to eq(false)

      cart = Cart.new({})
      cart.add_item(chain.id)
      order = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: Order.generate_code)
      order.generate_item_orders(cart)


      expect(bike_shop.has_item_orders?).to eq(true)
    end
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    end

    it "can count how many different items it is selling" do
      expect(@bike_shop.number_of_items).to eq(2)
      @chain.delete
      expect(@bike_shop.number_of_items).to eq(1)
    end

    it "can calculate the average price of all its items" do
      expect(@bike_shop.avg_price).to eq(75)
      @chain.delete
      expect(@bike_shop.avg_price).to eq(100)
    end

    it "can identify all cities where its items have been ordered" do
      cart = Cart.new({})
      cart.add_item(@tire.id)
      cart.add_item(@tire.id)
      @order_1 = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: Order.generate_code)
      @order_1.generate_item_orders(cart)
      cart = Cart.new({})
      cart.add_item(@tire.id)
      cart.add_item(@chain.id)
      cart.add_item(@chain.id)
      @order_2 = Order.create(name: "Joe", address: "234 Drive", city: "Boston", state: "MA", zip: "10101", grand_total: 200, verification: Order.generate_code)
      @order_2.generate_item_orders(cart)
      cart = Cart.new({})
      cart.add_item(@chain.id)
      @order_3 = Order.create(name: "Sam", address: "345 Way", city: "Boston", state: "MA", zip: "10101", grand_total: 200, verification: Order.generate_code)
      @order_3.generate_item_orders(cart)

      expect(@bike_shop.all_cities.sort).to eq(["Boston", "Denver"])
    end
  end
end
