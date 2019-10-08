require 'rails_helper'

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

RSpec.describe "review create page" do
  describe "when I visit the item's show page" do
    describe "I can click a link to create a review" do
      it "I can make a new review through a form" do
        @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

        @review_1 = @chain.reviews.create(title: "This stunk", content: "super smelly", rating: 1)
        @review_2 = @chain.reviews.create(title: "This blew my mind", content: "goddawful", rating: 1)

        visit "/items/#{@chain.id}"

        click_link "Review This Item"

        expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

        fill_in :title, with: "Cool chain dude."
        fill_in :content, with: "Off the chain."
        fill_in :rating, with: 5

        click_button "Submit Review"

        expect(current_path).to eq("/items/#{@chain.id}")
        expect(page).to have_content("Cool chain dude.")
        expect(page).to have_content("Off the chain.")
      end
    end
  end
end
