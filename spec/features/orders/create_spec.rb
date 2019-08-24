require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "Order Creation" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"
      visit "/cart"

      click_on "Checkout"
    end
    it "When I fill out all information on the new order page, and click on
    'Create Order' order is created and saved in the database, I am redirected
     to that order's show page with the following information: name, address,
     details of the order(name of items, merchant, price, desired quantity
     subtotal, grand total, date the order was created)" do

          name = "Leiya Kelly"
          address = '11 ILiveAtTuring Ave.'
          city = "Denver"
          state = "CO"
          zip = 80237

          fill_in :name, with: name
          fill_in :address, with: address
          fill_in :city, with: city
          fill_in :state, with: state
          fill_in :zip, with: zip

      click_on "Create Order"
      new_order = Order.last
      expect(current_path).to eq("/orders/#{new_order.id}")

      expect(new_order.name).to eq(name)
      expect(new_order.address).to eq(address)
      expect(new_order.city).to eq(city)
      expect(new_order.state).to eq(state)
      expect(new_order.zip).to eq(zip)

      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(city)
      expect(page).to have_content(state)
      expect(page).to have_content(zip)

      expect(page).to have_content("Item: #{@chain.name}")
      expect(page).to have_content("Sold By: #{@chain.merchant.name}")
      expect(page).to have_content("Price: #{@chain.price}")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Item Subtotal: 50.0")

      expect(page).to have_content("Grand Total: 150.0")
      expect(page).to have_content("Created at: #{new_order.created_at}")
    end
  end
end
