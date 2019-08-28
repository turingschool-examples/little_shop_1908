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
    it { should belong_to :merchant }
    it { should have_many :item_orders }
    it { should have_many :orders }
  end

  describe "class methods" do
    before :each do
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "can get all items from the cart" do
      cart = Cart.new({@pull_toy.id.to_s=>1, @dog_bone.id.to_s=>2})
      items = [@pull_toy, @dog_bone]

      expect(Item.cart_items(cart)).to eq(items)
    end

    it "item #exists?" do
      expect(Item.exists?(@pull_toy.id)).to eq(true)
      expect(Item.exists?(0)).to eq(false)
    end
  end

  describe 'instance methods' do
    it "can tell if an item has orders" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      light = bike_shop.items.create(name: "Lights", description: "So bright!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      expect(light.has_orders?).to eq(false)

      order = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      item_order = order.item_orders.create(quantity: 2, total_cost: 100, item: light)

      expect(light.has_orders?).to eq(true)
    end
  end
end
