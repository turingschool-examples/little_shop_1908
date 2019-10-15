require 'rails_helper'

RSpec.describe 'Create new review', type: :feature do
  describe 'When I visit item show page'
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    end

    it 'I see a link to add a new review' do
      visit "/items/#{@chain.id}"

      expect(page).to have_link('Add Review')
    end

    it 'I can add a review by filling out form' do
      title = "Great, durable @chain!"
      rating = 5
      content = "I've been using this @chain for over 500 miles and it hasn't had any issues. Highly recommend."

      visit "/items/#{@chain.id}"
      click_on 'Add Review'

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      fill_in :title, with: title
      fill_in :rating, with: rating
      fill_in :content, with: content

      click_button "Create Review"

      this_review = Review.last

      expect(@chain.reviews).to eq([this_review])
      expect(current_path).to eq("/items/#{@chain.id}")
      expect(this_review.title).to eq(title)
      expect(this_review.rating).to eq(rating)
      expect(this_review.content).to eq(content)
    end

    it 'Tells me when I need to finish completing form' do
      title = "Great, durable @chain!"
      content = "I've been using this @chain for over 500 miles and it hasn't had any issues. Highly recommend."

      visit "/items/#{@chain.id}"
      click_on 'Add Review'

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      fill_in :title, with: title
      fill_in :content, with: content

      click_button "Create Review"
      expect(page).to have_content("Please finish filling out form before submitting.")
    end

    it 'Tells me to rate between 1 and 5' do
      title = "Great, durable @chain!"
      rating = 6
      content = "I've been using this @chain for over 500 miles and it hasn't had any issues. Highly recommend."

      visit "/items/#{@chain.id}"
      click_on 'Add Review'

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      fill_in :title, with: title
      fill_in :rating, with: rating
      fill_in :content, with: content

      click_button "Create Review"
      expect(page).to have_content("Please finish filling out form before submitting.")
    end
end
