require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before (:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    # make some reviews for @chain
    # @review_1 = @chain.reviews.create(title: "This stunk", content: "super smelly", rating: 1)
    # @review_2 = @chain.reviews.create(title: "This blew my mind", content: "goddawful", rating: 1)
    visit "items/#{@chain.id}"
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

  it "shows reviews for an item" do
    ratings = [@rating_1, @rating_2]
    ratings.each do |rating|
      within "#rating-#{rating.id}" do 
        expect(page).to have_content(rating.title)
        expect(page).to have_content(rating.content)
        expect(page).to have_content(rating.rating)
      end
    end
  end
#   As a visitor,
# When I visit an item's show page,
# I see a list of reviews for that item
# Each review will have:
# - title
# - content of the review
# - rating (1 to 5)
end
