require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    it 'I can delete an item' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{chain.id}")
    end

    it "can not delete item when item is on order" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"
      click_button "Add Item"
      visit '/cart'
      click_link 'Checkout'
      visit '/orders/new'

      fill_in :name, with: 'Michael Jackson'
      fill_in :address, with: '123 Neverland Ranch Rd'
      fill_in :city, with: 'Hollywood'
      fill_in :state, with: 'California'
      fill_in :zip, with: '90210'

      click_button "Create Order"

      visit "/items/#{chain.id}"
      expect(page).to_not have_content("Delete Item")
    end
  end
end
