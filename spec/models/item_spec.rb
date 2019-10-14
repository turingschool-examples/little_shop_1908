require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should_not allow_value(nil).for(:active?) }
    
    it { should validate_numericality_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:inventory).only_integer }
    it { should validate_numericality_of(:inventory).is_greater_than(0) }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :reviews }
    it { should have_many :item_orders }
    it { should have_many :orders }
  end


  describe 'instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      user_1 = User.create(name: 'Kyle Pine', address: '123 Main Street', city: 'Greenville', state: 'NC', zip: '29583')
      user_2 = User.create(name: 'Steve Spruce', address: '456 2nd Street', city: 'Redville', state: 'SC', zip: '29444')
      order_1 = user_1.orders.create(grand_total: 100)
      order_1.item_orders.create(item_id: @tire.id, item_quantity: 2, subtotal: 50)

    end

    it 'can get the number of items' do
      expect(@meg.items.total_count).to eq(1)
      expect(@brian.items.total_count).to eq(2)
    end

    it 'can calculate the average price of items' do
      expect(@meg.items.average_price).to eq(100)
      expect(@brian.items.average_price).to eq(15)
    end
  end
end
