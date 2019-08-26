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
    it {should have_many(:items_orders).through(:items)}
  end

  describe "instance methods" do
    it "can count the total number of items for a merchant" do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
      pull_toy = bike_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)

      expect(bike_shop.total_items_count).to eq(2)
    end

    it "can calculate the average price of all items that belong to a merchant" do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
      pull_toy = bike_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)

      expect(bike_shop.average_price_items).to eq(55)
    end

    it "can display a list of distinct cities where items have been ordered" do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      tire = bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
      pull_toy = bike_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)
      dog_bone = bike_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      order_tr = tire.orders.create(name: "Bob", address: '123 Bob Rd.', city: 'Denver', state: 'CO', zip: "82222")
      order_pt = pull_toy.orders.create(name: "Bob", address: '123 Bob Rd.', city: 'Denver', state: 'CO', zip: "82222")
      order_db = dog_bone.orders.create(name: "Bob", address: '123 Bob Rd.', city: 'Denver', state: 'CO', zip: "82222")

      expect(bike_shop.list_cities).to eq(['Denver'])
    end
  end
end
