require 'rails_helper'

describe 'Review New Page' do
  before(:each) do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  end

  it 'has a form to create a new review' do
    visit "/items/#{@pull_toy.id}/reviews/new-review"

    title = "Don't Waste Your Money"
    content = "This piece of junk was half the size I thought it should be and it smelled bad."
    rating = 2

    fill_in :title, with: title
    fill_in :content, with: content
    select '2', from: :rating

    click_button "Submit Review"

    new_review = @pull_toy.reviews.last

    expect(current_path).to eq("/items/#{@pull_toy.id}")

    within "#review-#{new_review.id}" do
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content("2/5")
    end
  end

  it 'displays an error if the form to create a new review is not completed' do
    visit "/items/#{@pull_toy.id}/reviews/new-review"

    title = "Don't Waste Your Money"
    content = "This piece of junk was half the size I thought it should be and it smelled bad."
    rating = 2

    fill_in :title, with: title
    select '2', from: :rating

    click_button "Submit Review"

    expect(current_path).to eq("/items/#{@pull_toy.id}")

    expect(page).to have_content("Do it right, yo.")
    expect(page).to_not have_content("Don't Waste Your Money")

    visit "/items/#{@pull_toy.id}/reviews/new-review"

    fill_in :content, with: content
    select '2', from: :rating

    click_button "Submit Review"

    expect(current_path).to eq("/items/#{@pull_toy.id}")

    expect(page).to have_content("Do it right, yo.")
    expect(page).to_not have_content("This piece of junk was half the size I thought it should be and it smelled bad.")
  end 
end
