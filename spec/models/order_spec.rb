require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of :grand_total }
    it { should validate_presence_of :verification_code }

    it { should validate_numericality_of(:grand_total) }
    it { should validate_numericality_of(:grand_total).is_greater_than(0) }

    it { should validate_numericality_of(:verification_code).only_integer }
    it { should validate_length_of(:verification_code).is_equal_to(10) }
    it { should validate_uniqueness_of(:verification_code) }
  end

  describe 'relationships' do
    it { should have_many :item_orders }
    it { should have_many :items }

    it { should belong_to :user }
  end

  describe 'instance methods' do
    it 'can get the distint cities of where items have been ordered' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      user_1 = User.create(name: 'Kyle Pine', address: '123 Main Street', city: 'Greenville', state: 'NC', zip: '29583')
      order_1 = user_1.orders.create(grand_total: 100, verification_code: '9856758493')
      order_1.item_orders.create(item_id: @tire.id, item_quantity: 2, subtotal: 50)

      user_2 = User.create(name: 'Steve Spruce', address: '456 2nd Street', city: 'Redville', state: 'SC', zip: '29444')
      order_2 = user_2.orders.create(grand_total: 40, verification_code: '5456758493')
      order_2.item_orders.create(item_id: @pull_toy.id, item_quantity: 2, subtotal: 20)
      order_2.item_orders.create(item_id: @dog_bone.id, item_quantity: 1, subtotal: 20)

      user_3 = User.create(name: 'Steve Spruce', address: '456 2nd Street', city: 'Redville', state: 'SC', zip: '29444')
      order_3 = user_3.orders.create(grand_total: 40, verification_code: '3206758493')
      order_3.item_orders.create(item_id: @pull_toy.id, item_quantity: 2, subtotal: 20)
      order_3.item_orders.create(item_id: @dog_bone.id, item_quantity: 1, subtotal: 20)


      expect(Order.distinct_cities).to eq([['Greenville', 'NC'], ['Redville', 'SC']])
    end
  end
end
