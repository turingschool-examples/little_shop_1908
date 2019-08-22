require 'rails_helper'

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

    it "can see a delete button next to each review" do

      visit "items/#{@tire.id}"

      within "#review-#{@review_1.id}" do
        expect(page).to have_link("Delete Review")
      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_link("Delete Review")
      end

      within "#review-#{@review_5.id}" do
        expect(page).to have_link("Delete Review")
      end

      within "#review-#{@review_12.id}" do
        expect(page).to have_link("Delete Review")
      end
    end

    it "I can delete a merchant" do
      # skip
      visit "items/#{@tire.id}"

      within "#review-#{@review_12.id}" do
        click_link "Delete Review"
      end
      save_and_open_page

      expect(page).to_not have_content("Review Title 12")
      expect(page).to_not have_css("#review-#{@review_12.id}")
    end
  end
end
