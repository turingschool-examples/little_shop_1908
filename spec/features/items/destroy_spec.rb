require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    it 'I can delete an item' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{chain.id}")
    end

    it "When I delete an item, it deletes its reviews" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      lights = bike_shop.items.create(name: "Lights", description: "So bright!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review_1 = lights.reviews.create(title: "Super!", content: "Best lights!", rating: 5)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review_2 = chain.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 3)

      expect(Review.last).to eq(review_2)

      visit "/items/#{chain.id}"
      click_link 'Delete Item'

      expect(Review.last).to eq(review_1)
    end
  end
end
