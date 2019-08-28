# As a visitor
# When I visit a merchant's show page
# I see statistics for that merchant, including:
# - count of items for that merchant
# - average price of that merchant's items
# - Distinct cities where my items have been ordered


RSpec.describe "As a visitor" do
  before(:each) do
    #shops
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    #bike_shop items
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @bike = @bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)

    #dog_shop items
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @brush = @dog_shop.items.create(name: "Brush", description: "Great for long haired pets", price: 15, image: "https://images-na.ssl-images-amazon.com/images/I/71V8HaHa02L._SL1200_.jpg", inventory: 15)

    #tire_reviews
    @review_1 = @tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
    @review_2 = @tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
    @review_3 = @tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)

    #user orders
    @order_1 = Order.create(name: "Mack", address: "123 Happy St", city: "Denver", state: "CO", zip: "80205")
    @item_order_1 = ItemOrder.create(order: @order_1, item: @bike, quantity: 1, subtotal: @bike.item_subtotal(1))

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

    @order_5 = Order.create(name: "Adam", address: "123 South St", city: "Chicago", state: "IL", zip: "61704")
    @item_order_9 = ItemOrder.create(order: @order_5, item: @pull_toy, quantity: 5, subtotal: @pull_toy.item_subtotal(5))
    @item_order_10 = ItemOrder.create(order: @order_5, item: @tire, quantity: 2, subtotal: @tire.item_subtotal(2))

    @order_6 = Order.create(name: "Matt", address: "123 Road St", city: "Chicago", state: "IL", zip: "61704")
    @item_order_11 = ItemOrder.create(order: @order_6, item: @bike, quantity: 2, subtotal: @bike.item_subtotal(2))
    @item_order_12 = ItemOrder.create(order: @order_6, item: @brush, quantity: 1, subtotal: @brush.item_subtotal(1))
  end

  describe 'merchants can have stats on merchant show page' do
    it 'can show count of items for that merchant' do
      visit "/merchants/#{@bike_shop.id}"

      within "#merchant-stats" do
        expect(page).to have_content("Products: 2")
      end
    end

    it 'can show average price of that merchants items' do
      visit "/merchants/#{@bike_shop.id}"

      within "#merchant-stats" do
        expect(page).to have_content("Average Product Price: $150")
      end
    end

    it 'can show distinct cities where my items have been ordered' do

      visit "/merchants/#{@bike_shop.id}"

      within "#merchant-stats" do
        expect(page).to have_content("Shipped To: Denver, Golden, Chicago")
      end
    end
  end
end
