require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "when I visit the Review Edit Page" do
    it "I can modify title, content, rating" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      review = tire.reviews.create(title: "first review", content: "content", rating: 4)

      visit "/items/#{tire.id}/reviews/#{review.id}/edit"

      expect(find_field(:title).value).to eq(review.title)
      expect(find_field(:content).value).to eq(review.content)
      expect(find_field(:rating).value).to eq(review.rating.to_s)

      fill_in :title, with: "Love It!"
      fill_in :content, with: "I'd buy it again, totally fixed my bike issues!"
      fill_in :rating, with: 5

      click_button 'Update Review'

      expect(current_path).to eq("/items/#{tire.id}")

      within "#review-#{review.id}" do
        expect(page).to have_content("Love It!")
        expect(page).to have_content("I'd buy it again, totally fixed my bike issues!")
        expect(page).to have_content(5)

        expect(page).to_not have_content("first review")
        expect(page).to_not have_content("content")
        expect(page).to_not have_content(4)
      end
    end
  end
end
