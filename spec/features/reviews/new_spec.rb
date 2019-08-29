require 'rails_helper'

describe 'New Item Review' do
  describe 'When I visit the page to add an item review' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588(52 kB)', inventory: 12)
    end

    it 'I can fill out the review form and create a new review' do
      visit "/items/#{@tire.id}/review"

      title = 'Great tire'
      content = 'It works very well'
      rating = 5

      fill_in 'Title', with: title
      fill_in 'Content', with: content
      fill_in 'Rating', with: rating

      click_button 'Create Review'

      expect(current_path).to eq("/items/#{@tire.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
    end

    it 'a rating cannot be given greater than 5' do
      visit "/items/#{@tire.id}/review"

      title = 'Great tire'
      content = 'It works very well'
      rating = 6

      fill_in 'Title', with: title
      fill_in 'Content', with: content
      fill_in 'Rating', with: rating

      click_button 'Create Review'

      expect(page).to have_content("Review not created, required information missing, and rating must be between 1-5")
      expect(page).to have_button 'Create Review'
    end

    it 'a rating cannot be given less than 1' do
      visit "/items/#{@tire.id}/review"

      title = 'Great tire'
      content = 'It works very well'
      rating = 0

      fill_in 'Title', with: title
      fill_in 'Content', with: content
      fill_in 'Rating', with: rating

      click_button 'Create Review'

      expect(page).to have_content("Review not created, required information missing, and rating must be between 1-5")
      expect(page).to have_button 'Create Review'
    end

    it 'I cannot create a review without a title' do
      visit "/items/#{@tire.id}/review"

      content = 'It works very well'
      rating = 5

      fill_in 'Content', with: content
      fill_in 'Rating', with: rating
      click_button 'Create Review'

      expect(page).to have_content("Review not created, required information missing, and rating must be between 1-5")
      expect(page).to have_button 'Create Review'
    end

    it 'Shows flash message when content area of review not filled in' do
      visit "/items/#{@tire.id}/review"

      title = 'Great tire'
      rating = 5

      fill_in 'Title', with: title
      fill_in 'Rating', with: rating
      click_button 'Create Review'

      expect(page).to have_content("Review not created, required information missing, and rating must be between 1-5")
      expect(page).to have_button 'Create Review'
    end
  end
end
