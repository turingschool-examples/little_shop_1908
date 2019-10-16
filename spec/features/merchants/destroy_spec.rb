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

    it "Alerts the user that it cannot delete a merchant with orders" do
      chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
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
      visit "/merchants/#{@bike_shop.id}"
      click_link 'Delete Merchant'

      expect(page).to have_content("This merchant cannot be deleted because it has pending orders.")
    end
  end
end
