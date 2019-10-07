require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @bad_review = @chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
    @good_review = @chain.reviews.create(title: "Awesome chain!", content: "This was a great chain! Would buy again.", rating: 5)

    visit "/items/#{@chain.id}"
  end

  it 'shows item info' do
    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")
  end

  it 'shows list of review for that item' do
    within "#review-#{@good_review.id}" do
      expect(page).to have_content("Awesome chain!")
      expect(page).to have_content("This was a great chain! Would buy again.")
      expect(page).to have_content("Rating: 5")
    end

    within  "#review-#{@bad_review.id}" do
      expect(page).to have_content("Worst chain!")
      expect(page).to have_content("NEVER buy this chain.")
      expect(page).to have_content("Rating: 1")
    end
  end
end
