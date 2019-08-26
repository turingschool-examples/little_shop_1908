require 'rails_helper'

describe Merchant do
  describe "relationships" do
    it {should have_many :items}
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_numericality_of :zip }
  end

  describe "merchants has items ordered" do
    bikey_shop = Merchant.create(name: "Evette's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    doggy_shop = Merchant.create(name: "Evette's Dog Shop", address: '123 Dog Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = bikey_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    order = Order.create(name: "Evette", address: "123 street", city: "Denver", state: "CO", zip: 12345)
    io_1 = order.item_orders.create(item_id: tire.id, order_id: order.id, quantity: 5, total_cost: (tire.price * 5))

    it { expect(bikey_shop.has_items_ordered).to be true }
    it { expect(doggy_shop.has_items_ordered).to be false }
  end

  describe "stat model methods" do
    before(:each) do
      @pug_store = Merchant.create(name: "Puggotown", address: '123 Pupper Rd.', city: 'Pugville', state: 'VA', zip: 23137)
      @dog_food = @pug_store.items.create(name: "Foodtime", description: "It's yummy!", price: 10, image: "https://www.zooplus.co.uk/magazine/CACHE_IMAGES/768/content/uploads/2018/01/fotolia_108248133.jpg", inventory: 120)
      @soap = @pug_store.items.create(name: "Soapy Soap", description: "It's clean!", price: 11, image: "https://i.pinimg.com/originals/a9/bf/77/a9bf779477d6a97519cfe3b8c21dac90.jpg", inventory: 20)
      @order = Order.create(name: "Evette", address: "123 street", city: "Denver", state: "CO", zip: 12345)
      @order_2 = Order.create(name: "Other Evette", address: "123 other street", city: "New York", state: "NY", zip: 10019)
      @order.item_orders.create(item_id: @soap.id, order_id: @order.id, quantity: 5, total_cost: (@soap.price * 5))
      @order.item_orders.create(item_id: @dog_food.id, order_id: @order.id, quantity: 15, total_cost: (@dog_food.price * 15))
      @order_2.item_orders.create(item_id: @dog_food.id, order_id: @order.id, quantity: 150, total_cost: (@dog_food.price * 150))
    end

    it "should calculate total items" do
      expect(@pug_store.item_count).to eq(2)
    end

    it "should calculate avg item price" do
      expect(@pug_store.average_item_price).to eq(10.5)
    end

    it "should calculate all cities that had orders" do
      expect(@pug_store.cities_serviced).to eq([@order_2.city, @order.city])
    end
  end
end
