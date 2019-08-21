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
require 'rails_helper'

RSpec.describe 'Edit an Existing Review' do
  describe 'As a visitor' do
    describe 'When I see a review on an Item Show Page' do
      describe 'I can click on a link to Edit the review' do
        it 'I then see a prepopulated form with the current review details to edit' do
          before :each do
            @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
            @corina = @tire.reviews.create(title: 'Never Buy This Tire', content: "I bought two of these and they blew within a week of each other, a month after purchase", rating: 1)
          end

          visit "/items/#{@tire.id}"

          within
          expect(page).to have_link("Edit Review")
          end

          click_on 'Edit Review'

          expect(current_path).to eq("/reviews/#{@corina.id}/edit")
          expect(find_field('Title').value).to eq "Never Buy This Tire"
          expect(find_field('Review').value).to eq 'I bought two of these and they blew within a week of each other, a month after purchase'
          expect(find_field('Rating').value).to eq 1
        end
      end
    end
  end
end
