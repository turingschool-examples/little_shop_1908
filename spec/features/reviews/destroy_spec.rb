require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I can click a link next to review on item show page to delete it' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @review_1 = @chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
    end

    it 'displays all reviews without the deleted review' do
      visit "/items/#{@chain.id}"

      click_link 'Delete Review'

      expect(current_path).to eq("/items/#{@chain.id}")

      expect(page).to_not have_css("#review-#{@review_1.id}")
    end
  end
end
