require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end

    it "has merchant name link" do
      visit "/merchants"
      click_link "Brian's Bike Shop"
      expect(current_path).to eq("/merchants/#{@bike_shop.id}")

      visit "/items"
      click_link "Brian's Bike Shop"
      expect(current_path).to eq("/merchants/#{@bike_shop.id}")

      visit "/merchants/#{@bike_shop.id}/items"
      click_link("Brian's Bike Shop", match: :first)
      expect(current_path).to eq("/merchants/#{@bike_shop.id}")

      visit "/items/#{@chain.id}"
      click_link "Brian's Bike Shop"
      expect(current_path).to eq("/merchants/#{@bike_shop.id}")

    end
  end
end
