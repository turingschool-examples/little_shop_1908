require 'rails_helper'

describe "show page has delete button" do
  it "can delete review" do
  @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
  @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  @review_1 = @chain.reviews.create!(title: "Best Item Ever", content: "I mean it. This item is the best thing ever!", rating: 5)

  visit "/items/#{@chain.id}"

  click_link "Delete Review"
  
  expect(current_path).to eq("/items/#{@chain.id}")
  expect(page).to_not have_content("Best Item Ever")
  expect(page).to_not have_content("I mean it. This item is the best thing ever!")
  end
end
