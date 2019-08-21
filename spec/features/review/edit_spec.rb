
# When the form is submitted, I should return to that item's
# show page and I should see my updated review

require 'rails_helper'

RSpec.describe "Edit A Review" do
  describe "As a visitor, when I edit a review" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @review_1 = @chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
      @review_2 = @chain.reviews.create!(title: "Ew", content: "The worst", rating: 1)
    end

    it "When I visit an item's show page, I see a link to edit the review next to each review." do
      visit item_path(@chain)

      expect(page).to have_link("Edit Review")
    end

    it "When I visit an item's show page, I see a link to edit the review next to each review." do
      visit item_path(@chain)

      within("#review-#{@review_1.id}") do
        click_link "Edit Review"
        expect(current_path).to eq(edit_review_path(@chain, @review_1))
      end
    end

    # it "On this new page, I see a form that includes my review's title, numeric rating, and text and can update any of these fields and submit the form." do
    #   visit edit_review_path(@chain)
    #
    #   expect(page).to have_content("Edit Your Review")
    #   expect(page).to have_content("Headline")
    #   expect(page).to have_content("Thoroughly Meh")
    #   expect(page).to have_content("Rating (1-5)")
    #   expect(page).to have_content("Rating: 2")
    #   expect(page).to have_content("Write Your Review")
    #   expect(page).to have_content("It seems like it's not the sturdiest chain. Will udpate after 6 months to see how it holds up.")
    # end
    #
    # it "When the form is submitted, I should return to that item's show page and I should see my updated review." do
    #   visit item_path(@chain)
    #
    #   expect(current_path).to eq(item_path(@chain))
    # end
  end
end
