require 'rails_helper'

describe 'User visits the item show page' do
  describe 'They can click a link to delete a review' do
    it 'Deletes the review' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review = chain.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 3)

      visit "/items/#{chain.id}"

      within "#review-#{review.id}" do
        expect(page).to have_link('Delete')
        click_link 'Delete'
      end

      expect(current_path).to eq("/items/#{chain.id}")

      expect(page).to_not have_css("#item-#{chain.id}")
    end
  end
end
