require 'rails_helper'

RSpec.describe "Edit a Review" do
  describe "On an item's show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: "This stunk", content: "super smelly", rating: 1)
    end

    it "I can click a link to edit a review via form" do
      visit "/items/#{@chain.id}"
      
      click_link "Edit Review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/#{@review_1.id}/edit")

      fill_in 'Title', with: "Amaaaazing"
      fill_in 'Rating', with: 5
      fill_in 'Content', with: "The best chain in the history of chains"

      click_button "Update Review"

      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to have_content("Amaaaazing")
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content("The best chain in the history of chains")

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
