require 'rails_helper'

describe "review edit page" do
  it "can edit a review" do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create!(title: "Best Item Ever", content: "I mean it. This item is the best thing ever!", rating: 5)

    visit "/items/#{@chain.id}"

    click_link "Edit Review"
    expect(current_path).to eq("/items/#{@chain.id}/reviews/#{@review_1.id}/edit")

    fill_in :title, with: "Okay item"
    fill_in :content, with: "Just and okay item"
    fill_in :rating, with: 3

    click_button "Update Review"
    expect(current_path).to eq ("/items/#{@chain.id}")

    expect(page).to have_content "Okay item"
    expect(page).to have_content "Just and okay item"
    expect(page).to have_content "Rating: 3"
  end
end
