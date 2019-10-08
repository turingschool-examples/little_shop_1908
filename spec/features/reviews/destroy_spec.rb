require 'rails_helper'

RSpec.describe "review delete" do
  describe 'when I visit an item show page' do

    it "can click a link to delete a review" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review_1 = chain.reviews.create(title: "It'll never break!", content: "Great chain!", rating: 5)
      review_2 = chain.reviews.create(title: "Rusts quickly", content: "Oil it frequently", rating: 3)

      visit "/items/#{chain.id}"

      within "#review-#{review_1.id}" do
        click_link 'Delete Review'
      end

      expect(current_path).to eq("/items/#{chain.id}")
      expect(page).to_not have_css("#review-#{review_1.id}")
    end

  end
end
