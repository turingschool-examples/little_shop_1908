require 'rails_helper'

RSpec.describe "Delete a review" do
  describe "As a visitor when I delete a review" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
      @review_2 = @chain.reviews.create!(title: "Win!", content: "It IS a chain!!", rating: 5)
      @review_3 = @chain.reviews.create!(title: "Yay", content: "I can ride my bike now!", rating: 5)
      @review_4 = @chain.reviews.create!(title: "No Way!", content: "The worst", rating: 1)
      @review_5 = @chain.reviews.create!(title: "Not Mad, Just Disappointed", content: "I just want to ride my bicycle", rating: 2)
      @review_6 = @chain.reviews.create!(title: "Womp Womp", content: "I hate it", rating: 1)
    end
    it "When I visit an item's show page, I see a link next to each review to delete the review." do
      visit "items/#{@chain.id}"

      expect(page).to have_link("Delete Review")
    end
    it "When I delete a review I am returned to the item's show page, and no longer see that review." do

    end
  end
end
