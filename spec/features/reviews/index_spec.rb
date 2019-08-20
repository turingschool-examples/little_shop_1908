# As a visitor,
# When I visit an item's show page,
# I see a list of reviews for that item
# Each review will have:
# - title
# - content of the review
# - rating (1 to 5)
require 'rails_helper'

RSpec.describe 'From Item Show Page', type: :feature do
  describe 'see list of reviews' do
    before :each do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @corina = @tire.reviews.create(title: 'Never Buy This Tire', content: "I bought two of these and they blew within a week of each other, a month after purchase", rating: 1)
    end

    it "can see review for each item" do

      visit "/items/#{@tire.id}"

      within '#reviews-section' do
        @reviews.each do |review|
          within "#review-#{review.id}" do
            expect(page).to have_content(review.title)
            expect(page).to have_content(review.content)
            expect(page).to have_content("Rating: #{review.rating} stars")
          end
        end
      end
    end
  end
end
