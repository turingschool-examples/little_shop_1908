require 'rails_helper'

RSpec.describe 'Create Item Reviews' do
  describe 'When I visit an item show page' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "/items/#{@chain.id}"
      click_link 'Add New Review'
    end

    it 'I can click a link to fill out a new form for a review' do
      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

      title = 'Okay'
      content = 'Could be better'
      rating = 3

      fill_in :title, with: title
      fill_in :content, with: content
      fill_in :rating, with: rating

      click_button 'Create Review'

      new_review = Review.last

      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
      expect(new_review.title).to eq(title)
      expect(new_review.content).to eq(content)
      expect(new_review.rating).to eq(rating)
    end

    it 'I cannot create a new review without all fields in the form filled' do
      click_button 'Create Review'

      # save_and_open_page

      expect(page).to have_content("Review not created: Required information missing.")
      expect(page).to have_button('Create Review')
    end
  end
end
