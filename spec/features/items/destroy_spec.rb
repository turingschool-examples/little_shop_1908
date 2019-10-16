require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    it 'I can click a link to delete an item' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{chain.id}")
    end

    it "Clicking the link will delete an item even if it has reviews" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review = chain.reviews.create(title: "I love it", content: "Totally fixed my bike issues.", rating: 5)

      visit "/items/#{chain.id}"

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{chain.id}")
    end

    it "Alerts the user that it cannot delete an item with orders" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "/items/#{chain.id}"
      click_button 'Add to Cart'
      visit '/cart'
      click_button 'Checkout'
      fill_in :name, with: "Sam"
      fill_in :address, with: "123 Main St."
      fill_in :city, with: "Anytown"
      fill_in :state, with: "MZ"
      fill_in :zip, with: "80122"
      click_button 'Create Order'
      visit "/items/#{chain.id}"
      click_link 'Delete Item'

      expect(page).to have_content("This item cannot be deleted because it has pending orders.")
    end
  end
end
