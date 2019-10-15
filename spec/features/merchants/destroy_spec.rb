require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a merchant show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    end

    it "I can delete a merchant" do

      visit "merchants/#{@bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can delete a merchant that has items" do

      chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "merchants/#{@bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "can not delete merchant when merchant items are on order" do
      @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{@chain.id}"
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

      visit "/merchants/#{@bike_shop.id}"
      expect(page).to_not have_content("Delete Merchant")
    end
  end
end
