require 'rails_helper'

RSpec.describe "As a visitor" do
  before(:each) do

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
  end

  describe "When I visit a merchant show page" do
    it "I can delete a merchant" do

      visit '/merchants'
      expect(page).to have_css("#merchant-#{@bike_shop.id}")

      visit "merchants/#{@bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
      expect(page).to_not have_css("#merchant-#{@bike_shop.id}")
    end

    it "I can delete a merchant that has items and reviews" do

      visit "merchants/#{@bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "cannot delete a merchant that has orders" do

      order_1 = Order.create(
        name: "Mack", address: "123 Happy Street", city: "Denver", state: "Co", zip: "80205")

      item_order_1 = ItemOrder.create(
        order: order_1,
        item: @bike,
        quantity: 1,
        subtotal: @bike.item_subtotal(1))

      visit "/merchants/#{@bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}")
      expect(page).to have_content("Sorry, this merchant has orders and cannot be deleted.")
    end
  end
end
