require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{@chain.id}"
    end

    it 'I can delete an item' do

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{@chain.id}")
    end

    it 'I delete the item reviews when I delete the item' do
      review = @chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)

      click_on "Delete Item"
      # binding.pry

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{@chain.id}")
    end
  end
end
