require 'rails_helper'

RSpec.describe "Review Creation" do
  describe "As a visitor, when I create a new review" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @review_1 = @chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
      @review_2 = @chain.reviews.create!(title: "Ew", content: "The worst", rating: 1)
    end
    it "When I visit an item's show page, I see a link to add a new review for this item." do
      visit item_path(@chain)

      expect(page).to have_link("Add Review")
    end
    it "When I click on this link, I am taken to a new review path" do
      visit item_path(@chain)

      click_link "Add Review"
      expect(current_path).to eq(new_review_path(@chain))
    end
    it "On this new page, I see a form where I must enter my review's attributes" do
      visit new_review_path(@chain)
      # save_and_open_page
      expect(page).to have_content("Create A Review")
      expect(page).to have_content("Headline")
      expect(page).to have_content("Rating (1-5)")
      expect(page).to have_content("Write Your Review")
    end

    it "When the form is submitted, I should return to that item's show page and I should see my review text" do
      visit item_path(@chain)
      click_link "Add Review"

      expect(current_path).to eq(new_review_path(@chain))

      title = "Thoroughly Meh"
      rating = 2
      content = "It seems like it's not the sturdiest chain. Will udpate after 6 months to see how it holds up."

      fill_in :title, with: title
      fill_in :rating, with: rating
      fill_in :content, with: content
      click_on 'Submit Your Review'

      new_review = Review.last
      expect(current_path).to eq(item_path(@chain))
      expect(page).to have_content("Thoroughly Meh")
    end
  end
end
