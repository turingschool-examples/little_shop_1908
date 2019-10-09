require 'rails_helper'

describe "Review page", type: :feature do
  it "can make a new review" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create!(title: "Best Item Ever", content: "I mean it. This item is the best thing ever!", rating: 5)
    @review_2 = @chain.reviews.create!(title: "Waste Of Money", content: "What a total waste of money. This item broke on the first use.", rating: 1)

    visit "/items/#{@chain.id}"

    click_link "Write Review"
    expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

    fill_in "Title", with: "Best Item Ever"
    fill_in "Content", with: "I mean it. This item is the best thing ever!"
    fill_in "Rating", with: 5

    click_button "Submit Review"
    expect(current_path).to eq("/items/#{@chain.id}")
    expect(page).to have_content("I mean it. This item is the best thing ever!")
    expect(page).to have_content("Best Item Ever")
    expect(page).to have_content("5")
  end
end
