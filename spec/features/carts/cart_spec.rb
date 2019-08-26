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
    expect(page).to have_content("You now have 1 #{@tire.name} in your cart.")
  end

  it "the message correctly increments for multiple items" do

    visit "/items/#{@brush.id}"
    click_button "Add Item"

    visit "/items/#{@brush.id}"
    click_button "Add Item"

    expect(current_path).to eq("/items")
    expect(page).to have_content("You now have 2 #{@brush.name}es in your cart.")
  end

  it "displays the total number of items in the cart" do
    visit "/items"
    expect(page).to have_content("0")

    visit "/items/#{@tire.id}"
    click_button "Add Item"
    expect(page).to have_content("1")

    visit "/items/#{@pull_toy.id}"
    click_button "Add Item"
    expect(page).to have_content("2")

    visit "/items/#{@brush.id}"
    click_button "Add Item"
    expect(page).to have_content("3")
  end
end

# As a visitor
# When I have items in my cart
# And I visit my cart
# Next to each item in my cart
# I see a button or link to remove that item from my cart
# - clicking this button will remove the item but not other items
RSpec.describe 'When a user visits their cart with items' do
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

  it 'sees a button next to each item to delete it' do
    visit "/items/#{@tire.id}"
    click_button "Add Item"

    visit "/items/#{@bike.id}"
    click_button "Add Item"

    visit "/items/#{@pull_toy.id}"
    click_button "Add Item"

    visit '/cart'

    within "#cart-item-#{@tire.id}" do
      click_button 'Delete Item'
    end

    expect(page).to_not have_css("#cart-item-#{@tire.id}")

    within "#cart-item-#{@bike.id}" do
      click_button 'Delete Item'
    end

    expect(page).to_not have_css("#cart-item-#{@bike.id}")

    within "#cart-item-#{@pull_toy.id}" do
      click_button 'Delete Item'
    end

    expect(page).to_not have_css("#cart-item-#{@pull_toy.id}")
  end
end

# As a visitor
# When I have items in my cart
# And I visit my cart
# Next to each item in my cart
# I see a button or link to decrement the count of items I want to purchase
# If I decrement the count to 0 the item is immediately removed from my cart

RSpec.describe "When Visiting the Cart Show Page" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @bike = @bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)
  end

  it "should see a button to decrement the count of an item" do
    visit "/items/#{@tire.id}"
    click_button "Add Item"

    visit "/items/#{@tire.id}"
    click_button "Add Item"

    visit "/items/#{@bike.id}"
    click_button "Add Item"

    visit '/cart'

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_link("-")

      click_link "-"
    end

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content('Quantity: 1')
    end
  end

  it 'removes item completely if quantity is decremented to zero' do
    visit "/items/#{@bike.id}"
    click_button "Add Item"

    visit '/cart'

    within "#cart-item-#{@bike.id}" do

      click_link "-"
    end

    expect(page).to_not have_css("#cart-item-#{@bike.id}")
  end
end
