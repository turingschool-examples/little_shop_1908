require 'rails_helper'

describe "As a visitor" do
  describe "There is a edit review button" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @review_1 = @chain.reviews.create(title: "Best Chain!", content: "It never broke!", rating: 5)
      visit "/items/#{@chain.id}"
    end
    it "can lead to a edit form for that review" do

      within "#item-review-#{@review_1.id}" do
        click_link "Edit Review"
      end

      expect(current_path).to eq("/items/#{@chain.id}/reviews/#{@review_1.id}/edit")
      fill_in :title, with: 'Bestest chain!'
      fill_in :content, with: 'It never brokened!'
      select "4", from: :rating
      click_button 'Update Review'

      expect(current_path).to eq("/items/#{@chain.id}")

      within "#item-review-#{@review_1.id}" do
        expect(page).to have_content('Bestest chain!')
        expect(page).to have_content('It never brokened!')
        expect(page).to have_content('4')
      end
    end
  end
end
