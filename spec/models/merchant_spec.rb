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
    it {should have_many(:item_orders).through(:items)}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe 'instance methods' do
    it '#has_orders?' do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      expect(dog_shop.has_orders?).to eq(false)

      order = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      item_order = order.item_orders.create(quantity: 2, total_cost: 15, item: dog_bone)

      expect(dog_shop.has_orders?).to eq(true)
    end

    it "#best-items" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      light = bike_shop.items.create(name: "Light", description: "Its a light!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      horn = bike_shop.items.create(name: "Horn", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      review_1 = chain.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 1)
      review_2 = tire.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 2)
      review_3 = light.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 3)
      review_4 = horn.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 4)
      expect(bike_shop.best_items).to eq([horn, light, tire])
    end

    it '#count_items' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      expect(bike_shop.count_items).to eq(2)
    end

    it '#average_price' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      expect(bike_shop.average_price).to eq(70.0)
    end

    it '#distinct_cities' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      order_1 = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      order_2 = Order.create(name: "Phil", address: "456 A st.", city: "Lake Forest", state: "IL", zip: 60045)
      order_3 = Order.create(name: "Phil", address: "456 A st.", city: "Lake Forest", state: "IL", zip: 60045)
      item_order_1 = order_1.item_orders.create(quantity: 1, total_cost: 100, item: tire)
      item_order_2 = order_2.item_orders.create(quantity: 1, total_cost: 40, item: chain)
      item_order_3 = order_3.item_orders.create(quantity: 1, total_cost: 40, item: chain)

      expect(bike_shop.distinct_cities).to eq(["Lake Forest", "Torrance"])
    end
  end
end
