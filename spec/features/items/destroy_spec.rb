require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    it 'I can delete an item' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"

      expect(page).to have_link("Delete Item")

      click_link "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{chain.id}")
    end

    it "I cannot delete an item that has been ordered" do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      order_1 = chain.orders.create!(name: "Sal Espinoza", address: "123 Great Lane", city: "New York City", state: "NY", zip: "88888")

      visit "/items/#{chain.id}"

      click_on "Delete Item"

      expect(current_path).to eq("/items/#{chain.id}")

      expect(page).to have_content("This item has been ordered and cannot be deleted at this time.")
    end
  end
end
