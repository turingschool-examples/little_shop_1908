require 'rails_helper'

# As a visitor,
# When I visit an item's show page,
# I see a link next to each review to delete the review.
# When I delete a review I am returned to the item's show page
# Then I should no longer see that review.

RSpec.describe "As a visitor" do
  describe "When I visit an item's show page" do
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
    end

    it "I can see a delete button for each review" do
    end

    it "I can delete a review" do
      skip
      visit '/item/#{@}'
      expect(page).to have_css("#merchant-#{bike_shop.id}")

      visit "merchants/#{bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
      expect(page).to_not have_css("#merchant-#{bike_shop.id}")
    end
  end
end
