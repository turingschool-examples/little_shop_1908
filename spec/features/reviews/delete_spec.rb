require 'rails_helper'

RSpec.describe "As a visitor on the item show page" do
  it 'I can click a link to delete a review' do
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    review_1 = chain.reviews.create(title: "first review", content: "content", rating: 4)

    visit "/items/#{chain.id}"

    within "#review-#{review_1.id}" do
      expect(page).to have_button("Delete Review")

      click_button "Delete Review"
    end

      expect(current_path).to eq("/items/#{chain.id}")

      expect(page).to_not have_content("first review")
      expect(page).to_not have_content("content")
      expect(page).to_not have_content(4)
  end
end
