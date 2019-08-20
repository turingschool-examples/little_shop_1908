require 'rails_helper'

describe 'User visits the item show page' do
  describe 'They can click a link and fill in form to edit review' do
    it 'Edits the original review' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review = chain.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 3)

      visit "/items/#{chain.id}"

      within "#review-#{review.id}" do
        click_link 'Edit Review'
      end

      expect(current_path).to eq('/reviews/edit')
      expect(page).to have_link('Chain') # In title 'Edit Review for item_path'
      expect(find_field('Title').value).to eq('Its Great!')
      expect(find_field('Content').value).to eq('Best chain ever!')
      expect(find_field('Rating').value).to eq('3')

      fill_in 'Rating', with: 5

      click_on 'Submit'

      expect(current_path).to eq("/items/#{chain.id}")

      within "#review-#{review.id}" do
        expect(page).to have_content('Its Great!')
        expect(page).to have_content('Best chain ever!')
        expect(page).to have_content("Rating: 5")
      end
    end
  end
end
# As a visitor,
# When I visit an item's show page
# I see a link to edit the review next to each review.
# When I click on this link, I am taken to an edit review path
# On this new page, I see a form that includes:
# - title
# - numeric rating
# - text of the review itself
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that item's
# show page and I should see my updated review
