require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a merchant show page" do
    it "I can delete a merchant" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

      visit "merchants/#{bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")

      expect(page).to_not have_css("#merchant-#{bike_shop.id}")
    end

    it "I can delete a merchant that has items and its items are also deleted" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/merchants/#{bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
      expect { chain.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it "I cannot delete a merchant that has items that have been ordered" do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      order_1 = chain.orders.create!(name: "Sal Espinoza", address: "123 Great Lane", city: "New York City", state: "NY", zip: "88888")

      visit "/merchants/#{bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq("/merchants/#{bike_shop.id}")

      expect(page).to have_content("This merchant has items that have been ordered. This merchant cannot be deleted at this time.")
    end
  end
end
