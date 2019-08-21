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
        @tire.reviews.each do |review|
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

# As a visitor
# When I visit an item's show page,
# I see an area on the page for statistics about reviews:
# - the top three reviews for this item (title and rating only)
# - the bottom three reviews for this item  (title and rating only)
# - the average rating of all reviews for this item

RSpec.describe 'From Item Show Page', type: :feature do
  describe 'see list of reviews' do
    before :each do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @review_1 = @tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
      @review_2 = @tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
      @review_3 = @tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)
      @review_4 = @tire.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 4)
      @review_5 = @tire.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 5)
      @review_6 = @tire.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 1)
      @review_7 = @tire.reviews.create(title: 'Review Title 7', content: "Content 7", rating: 2)
      @review_8 = @tire.reviews.create(title: 'Review Title 8', content: "Content 8", rating: 3)
      @review_9 = @tire.reviews.create(title: 'Review Title 9', content: "Content 9", rating: 4)
      @review_10 = @tire.reviews.create(title: 'Review Title 10', content: "Content 10", rating: 5)
      @review_11 = @tire.reviews.create(title: 'Review Title 11', content: "Content 11", rating: 1)
      @review_12 = @tire.reviews.create(title: 'Review Title 12', content: "Content 12", rating: 1)

      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @review_13 = @pull_toy.reviews.create(title: 'Review Title 13', content: "Content 13", rating: 5)
      @review_14 = @pull_toy.reviews.create(title: 'Review Title 14', content: "Content 14", rating: 5)
      @review_15 = @pull_toy.reviews.create(title: 'Review Title 15', content: "Content 15", rating: 4)
      @review_16 = @pull_toy.reviews.create(title: 'Review Title 16', content: "Content 16", rating: 4)
      @review_17 = @pull_toy.reviews.create(title: 'Review Title 17', content: "Content 17", rating: 3)
      @review_18 = @pull_toy.reviews.create(title: 'Review Title 18', content: "Content 18", rating: 3)
      @review_19 = @pull_toy.reviews.create(title: 'Review Title 19', content: "Content 19", rating: 2)
      @review_20 = @pull_toy.reviews.create(title: 'Review Title 20', content: "Content 20", rating: 2)
      @review_21 = @pull_toy.reviews.create(title: 'Review Title 21', content: "Content 21", rating: 1)
      @review_22 = @pull_toy.reviews.create(title: 'Review Title 22', content: "Content 22", rating: 1)
      @review_23 = @pull_toy.reviews.create(title: 'Review Title 23', content: "Content 23", rating: 5)
      @review_24 = @pull_toy.reviews.create(title: 'Review Title 24', content: "Content 24", rating: 5)
    end

    it "show the top three reviews for this item" do
      skip
      visit "/items/#{@tire.id}"

      within '#reviews-stat-section' do
        #binding.pry
        expect(page).to have_content(@review_5.title)
        expect(page).to have_content(@review_10.title)
        expect(page).to have_content(@review_4.title)
        expect(page).to have_content(@review_5.rating)
        expect(page).to have_content(@review_10.rating)
        expect(page).to have_content(@review_4.rating)
      end
    end

    it "show the bottom three reviews for this item" do
      skip
      visit "/items/#{@tire.id}"

      within '#reviews-stat-section' do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_6.title)
        expect(page).to have_content(@review_11.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_6.rating)
        expect(page).to have_content(@review_11.rating)
      end
    end

    it "can show the average rating of all reviews" do

      visit "/items/#{@tire.id}"

      within '#reviews-stat-section' do
        expect(page).to have_content(2.67)
      end
    end
  end
end
