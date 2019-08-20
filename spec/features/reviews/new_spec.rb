require 'rails_helper'

describe 'Review New Page' do
  before(:each) do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  end

  xit 'has a form to create a new review' do
    visit "/items/#{@pull_toy.id}/reviews/new-review"

    title = "Don't Waste Your Money"
    description = "This piece of junk was half the size I thought it should be and it smelled bad."
    rating = 1

    fill_in :title, with: title
    fill_in :description, with: description
    fill_in :rating, with: rating

    click_button "Submit Review"

    new_review = @pull_toy.reviews.last

    expect(current_path).to eq("/items/#{@pull_toy.id}")

    within "#review-#{new_review.id}" do
      expect(page).to have_content(title)
      expect(page).to have_content(description)
      expect(page).to have_content(rating)
    end
  end
end
