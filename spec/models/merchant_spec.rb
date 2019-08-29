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

  describe "methods" do
    before :each do
      #shops
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      #bike_shop items
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @bike = @bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 220, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)
      @glove = @bike_shop.items.create(name: "Gloves", description: "You wear them on your hands!", price: 40, image: "http://pngriver.com/wp-content/uploads/2017/11/gloves-free-PNG-transparent-background-images-free-download-clipart-pics-PNGPIX-COM-Gloves-PNG-Transparent-Image-500x337.png", inventory: 30)

      #dog_shop items
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @brush = @dog_shop.items.create(name: "Brush", description: "Great for long haired pets", price: 30, image: "https://images-na.ssl-images-amazon.com/images/I/71V8HaHa02L._SL1200_.jpg", inventory: 15)

      #tire_reviews
      @review_1 = @tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
      @review_2 = @tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
      @review_3 = @tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)

      #user orders
      @order_1 = Order.create!(name: "Mack", address: "123 Happy St", city: "Colorado Springs", state: "CO", zip: "80205")
        @item_order_1 = @order_1.item_orders.create!(order: @order_1, item: @bike, quantity: 1, subtotal: @bike.item_subtotal(1))

      @order_2 = Order.create(name: "John", address: "123 West St", city: "Golden", state: "CO", zip: "56600")
        @item_order_2 = ItemOrder.create(order: @order_2, item: @tire, quantity: 12, subtotal: @tire.item_subtotal(12))
        @item_order_3 = ItemOrder.create(order: @order_2, item: @brush, quantity: 3, subtotal: @brush.item_subtotal(3))

      @order_3 = Order.create(name: "Amber", address: "123 East St", city: "Denver", state: "CO", zip: "80205")
        @item_order_4 = ItemOrder.create(order: @order_3, item: @pull_toy, quantity: 4, subtotal: @pull_toy.item_subtotal(4))
        @item_order_5 = ItemOrder.create(order: @order_3, item: @brush, quantity: 3, subtotal: @brush.item_subtotal(3))
        @item_order_6 = ItemOrder.create(order: @order_3, item: @tire, quantity: 1, subtotal: @tire.item_subtotal(1))

      @order_4 = Order.create(name: "Emily", address: "123 North St", city: "Golden", state: "CO", zip: "56601")
        @item_order_7 = ItemOrder.create(order: @order_4, item: @tire, quantity: 1, subtotal: @tire.item_subtotal(1))
        @item_order_8 = ItemOrder.create(order: @order_4, item: @bike, quantity: 1, subtotal: @bike.item_subtotal(1))

      @order_5 = Order.create(name: "Adam", address: "123 South St", city: "Seattle", state: "WA", zip: "61704")
        @item_order_10 = ItemOrder.create(order: @order_5, item: @tire, quantity: 2, subtotal: @tire.item_subtotal(2))

      @order_6 = Order.create(name: "Matt", address: "123 Road St", city: "Denver", state: "CO", zip: "61704")
        @item_order_11 = ItemOrder.create(order: @order_6, item: @bike, quantity: 2, subtotal: @bike.item_subtotal(2))

      @order_7 = Order.create(name: "Julie", address: "123 Red St", city: "Denver", state: "CO", zip: "61704")
        @item_order_12 = ItemOrder.create(order: @order_7, item: @bike, quantity: 2, subtotal: @bike.item_subtotal(2))

      @order_8 = Order.create(name: "Julie", address: "123 Red St", city: "Denver", state: "CO", zip: "61704")
        @item_order_13 = ItemOrder.create(order: @order_8, item: @bike, quantity: 2, subtotal: @bike.item_subtotal(2))
    end

    it 'can return the number of unique products a merchant sells' do

      expect(@bike_shop.num_products).to eq(3)
      expect(@dog_shop.num_products).to eq(2)
    end

    it 'can return the average price of all merchants items' do

      expect(@bike_shop.avg_price).to eq(120)
      expect(@dog_shop.avg_price).to eq(20)
    end

    it 'can return the cities a merchant has shipped to' do

      expected_1 = ["Colorado Springs", "Denver", "Golden", "Seattle"]
      expected_2 = ["Denver", "Golden"]

      expect(@bike_shop.shipped_to_cities).to eq(expected_1)
      expect(@dog_shop.shipped_to_cities).to eq(expected_2)
    end
  end
end
