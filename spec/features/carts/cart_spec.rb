require 'rails_helper'
# As a visitor
# When I visit an item's show page from the items index
# I see a link or button to add this item to my cart
# And I click this link or button
# I am returned to the item index page
# I see a flash message indicating the item has been added to my cart
# The cart indicator in the navigation bar increments my cart count

RSpec.describe "When a user adds items to their cart" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    #bike_shop items
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @bike = @bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)

    #dog_shop items
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @brush = @dog_shop.items.create(name: "Brush", description: "Great for long haired pets", price: 15, image: "https://images-na.ssl-images-amazon.com/images/I/71V8HaHa02L._SL1200_.jpg", inventory: 15)
  end

  it 'displays a message' do
    visit "/items/#{@tire.id}"

    click_button "Add Item"

    expect(current_path).to eq("/items")
    expect(page).to have_content("Item successfully added to your cart")

    within "#cart-indicator" do
      expect(page).to have_content(1)
    end
  end
end
