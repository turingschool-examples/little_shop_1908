require 'rails_helper'

describe "Review page", type: :feature do
  it "can make a new review" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/items/#{@chain.id}"
    click_link "Write Review"
    expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

    fill_in :title, with: "Best Item Ever"
    fill_in :content, with: "I mean it. This item is the best thing ever!"
    fill_in :rating, with: 5

    click_button "Submit Review"
    expect(current_path).to eq("/items/#{@chain.id}")
    expect(page).to have_content("I mean it. This item is the best thing ever!")
    expect(page).to have_content("Best Item Ever")
    expect(page).to have_content("5")
  end

  describe 'cannot add review', type: :feature do
    it 'cannot add if form not complete' do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/items/#{@chain.id}/reviews/new"

    fill_in :title, with: ""
    fill_in :content, with: ""
    fill_in :rating, with: ""

    click_button "Submit Review"

    expect(page).to have_content "Review not created. Please fill in all fields"
    expect(page).to have_button("Submit Review")
  end
end
end
