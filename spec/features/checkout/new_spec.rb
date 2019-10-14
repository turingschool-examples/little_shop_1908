require 'rails_helper'

RSpec.describe 'Checkout new page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
    @chain = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 2)
    @tire = @bike_shop.items.create!(name: 'Tire', description: 'This is a tire.', price: 30, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 7)
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'

    visit '/cart'

    click_link 'Checkout'
  end
  it 'can show cart details and shipping form' do
    within "#checkout-#{@chain.id}" do
      expect(page).to have_content(@chain.name)
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content(@chain.merchant.name)
      expect(page).to have_content(@chain.price)
      expect(page).to have_content('Count: 1')
      expect(page).to have_content('Subtotal: $50.00')
    end

    expect(page).to have_content('Grand Total: $50.00')

    fill_in 'Name', with: 'Joe'
    fill_in 'Address', with: '123 Test Drive'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: 80128

    expect(page).to have_button('Create Order')
  end

  it "can create and save order and redirect to order show page" do
    fill_in 'Name', with: 'Joe'
    fill_in 'Address', with: '123 Test Drive'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: 80128

    click_button 'Create Order'

    order = Order.last

    expect(current_path).to eq("/order/#{order.id}")

    expect(page).to have_content("Order Date: #{order.date}")

    within "#order-#{@chain.id}" do
      expect(page).to have_content(@chain.name)
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content(@chain.merchant.name)
      expect(page).to have_content(@chain.price)
      expect(page).to have_content('Count: 1')
      expect(page).to have_content('Subtotal: $50.00')
    end

    within "#shipping-#{order.id}" do
      expect(page).to have_content(order.customer_name)
      expect(page).to have_content(order.customer_address)
      expect(page).to have_content(order.customer_city)
      expect(page).to have_content(order.customer_state)
      expect(page).to have_content(order.customer_zip)
    end

    expect(page).to have_content('Grand Total: $50.00')
  end
end

# As a visitor
# When I fill out all information on the new order page
# And click on 'Create Order'
# An order is created and saved in the database
# And I am redirected to that order's show page with the following information:
# - My name and address (shipping information)
# - Details of the order:
# - the name of the item
# - the merchant I'm buying this item from
# - the price of the item
# - my desired quantity of the item
# - a subtotal (price multiplied by quantity)
# - a grand total of what everything in my cart will cost
# - the date when the order was created
