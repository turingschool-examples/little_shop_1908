require 'rails_helper'

RSpec.describe 'item show page', type: :feature do

  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end

  it 'shows item info' do
    visit "/items/#{@chain.id}"
    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")
  end

  it 'shows list of reviews for item' do
    review_1 = @chain.reviews.create(title: "first review", content: "content", rating: 4)
    review_2 = @chain.reviews.create(title: "second review", content: "more content", rating: 5)

    visit "/items/#{@chain.id}"

    within "#review-#{review_1.id}" do
      expect(page).to have_content("first review")
      expect(page).to have_content("content")
      expect(page).to have_content(4)
    end

    within "#review-#{review_2.id}" do
      expect(page).to have_content("second review")
      expect(page).to have_content("more content")
      expect(page).to have_content(5)
    end
  end

  it 'shows a link to edit a review' do
    review_1 = @chain.reviews.create(title: "first review", content: "content", rating: 4)

    visit "/items/#{@chain.id}"

    within "#review-#{review_1.id}" do
      expect(page).to have_button("Edit Review")
      
      click_button "Edit Review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/#{review_1.id}/edit")
    end
  end
end
