require 'rails_helper'

RSpec.describe 'Site Navigation', type: :feature do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do

      visit '/merchants'
      within 'nav' do
        click_link 'Items'
      end
      expect(current_path).to eq('/items')
      within 'nav' do
        click_link 'Merchants'
      end
      expect(current_path).to eq('/merchants')
    end

    it "has a cart indicator" do
      scott = Merchant.create!(name: 'Scotts Salads', address: '343 lala lane', city: 'Denver', state: 'CO', zip: 80011)
      salad = scott.items.create!(name: "ultimate house", description: "House salad", price: 500, image: "https://www.theanthonykitchen.com/wp-content/uploads/2017/01/House-Salad-6-768x512.jpg", inventory: 9000)

      visit '/merchants'
      expect(page).to have_content("Cart")
      visit '/merchants/new'
      expect(page).to have_content("Cart")
      visit "/merchants/#{scott.id}"
      expect(page).to have_content("Cart")
      visit '/items'
      expect(page).to have_content("Cart")
      visit "/merchants/#{scott.id}/items"
      expect(page).to have_content("Cart")
      visit "/items/#{salad.id}"
      expect(page).to have_content("Cart")
    end
  end
end
