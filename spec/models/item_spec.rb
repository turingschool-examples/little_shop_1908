require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    it "can check if it has item orders" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      expect(chain.has_item_orders?).to eq(false)

      cart = Cart.new({})
      cart.add_item(chain.id)
      order = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: Order.generate_code)
      order.generate_item_orders(cart)


      expect(chain.has_item_orders?).to eq(true)
    end
  end
end
