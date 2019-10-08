require 'rails_helper'

RSpec.describe 'item show page', type: :feature do

  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    # @review_1 = @chain.reviews.create(title: "Best Item Ever", content: "I mean it. This item is the best thing ever!", rating: 5)
    # @review_2 = @chain.reviews.create(title: "Waste Of Money", content: "What a total waste of money. This item broke on the first use.", rating: 1)

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

  # it 'shows a list of reviews for that item' do
  #   within "#review-#{review_1.id}" do
  #     expect(page).to have_content("Best Item Ever")
  #     expect(page).to have_content("I mean it. This item is the best thing ever!")
  #     expect(page).to have_content(5)
  #   end
  #
  #   within "#review-#{review_2.id}" do
  #     expect(page).to have_content("Waste Of Money")
  #     expect(page).to have_content("What a total waste of money. This item broke on the first use.")
  #     expect(page).to have_content(1)
  #   end
  # end
end
