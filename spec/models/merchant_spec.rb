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

  describe 'instance methods' do
    it '#has_orders?' do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      expect(dog_shop.has_orders?).to eq(false)

      order = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      item_order = order.item_orders.create(quantity: 2, total_cost: 15, item: dog_bone)

      expect(dog_shop.has_orders?).to eq(true)
    end
  end
end
