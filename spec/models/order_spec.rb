require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe "methods" do
    before :each do
      #shops
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      #bike_shop items
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @bike = @bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)

      #dog_shop items
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @brush = @dog_shop.items.create(name: "Brush", description: "Great for long haired pets", price: 15, image: "https://images-na.ssl-images-amazon.com/images/I/71V8HaHa02L._SL1200_.jpg", inventory: 15)

      @order_1 = Order.create(name: "Amber", address: "123 East St", city: "Denver", state: "CO", zip: "80205")
        @item_order_1 = ItemOrder.create(order: @order_1, item: @pull_toy, quantity: 4, subtotal: @pull_toy.item_subtotal(4))
        @item_order_2 = ItemOrder.create(order: @order_1, item: @brush, quantity: 3, subtotal: @brush.item_subtotal(3))
        @item_order_3 = ItemOrder.create(order: @order_1, item: @tire, quantity: 1, subtotal: @tire.item_subtotal(1))

    end

    it 'can create a hash with order and quantity' do
      expected = {@pull_toy => 4, @brush => 3, @tire => 1}

      expect(@order_1.order_details).to eq(expected)
    end

    it 'can find the total of an order' do

      expect(@order_1.order_total).to eq(185)
    end
  end
end
