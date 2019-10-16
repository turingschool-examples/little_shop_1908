require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :grand_total }
    it { should validate_presence_of :verification}
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe '#generate_item_orders' do
    it "can generate item_orders for every item in the order" do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      cart = Cart.new({})
      cart.add_item(@tire.id)
      cart.add_item(@tire.id)
      cart.add_item(@chain.id)

      order = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: Order.generate_code)

      order.generate_item_orders(cart)

      expect(ItemOrder.first.order_id).to eq(order.id)
      expect(ItemOrder.first.item_id).to eq(@tire.id)
      expect(ItemOrder.first.quantity).to eq(2)
      expect(ItemOrder.first.subtotal).to eq(200)

      expect(ItemOrder.last.order_id).to eq(order.id)
      expect(ItemOrder.last.item_id).to eq(@chain.id)
      expect(ItemOrder.last.quantity).to eq(1)
      expect(ItemOrder.last.subtotal).to eq(50)
    end
  end

  describe 'generate_code' do
    it "can generate a random ten digit number that hasn't been used yet" do
      ex_verification = Order.generate_code
      expect(ex_verification.length).to eq(10)
    end
  end
end
