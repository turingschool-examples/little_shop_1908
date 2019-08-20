# As a visitor,
# When I visit an item's show page
# I see a link to add a new review for this item.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - a review title
# - a numeric rating that can only be a number from 1 to 5
# - some text for the review itself
# When the form is submitted, I should return to that item's
# show page and I should see my review text.
require 'rails_helper'

RSpec.describe 'Create New Review' do
  before :each do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  end

  it 'can add new review for item' do
    visit "/items/#{@tire.id}"

    within '#reviews-section' do
      click_link 'New Review'
    end

    expect(current_path).to eq("/items/#{@tire.id}/reviews/new")

    fill_in :title, with: 'Love it!'
    fill_in :content, with: 'Best ride ever!'
    fill_in :rating, with: 5

    click_button 'Save Review'

    new_review = Review.last

    expect(current_path).to eq("/items/#{@tire.id}")
    expect(page).to have_content(new_review.title)
    expect(page).to have_content(new_review.content)
    expect(page).to have_content(new_review.rating)
    expect(page).to have_css("#review-#{new_review.id}")
  end
end
