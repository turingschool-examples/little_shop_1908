require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit an items show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @good_review = @chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
    end

    it "it shows a link next to each review to delete the review and review is deleted" do
      visit "items/#{@chain.id}"

      expect(page).to have_link("Delete")
      click_on "Delete"

      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to_not have_css("#review-#{@good_review.id}")
      expect { @good_review.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it "I can delete an item and its reviews are also deleted" do
      visit "items/#{@chain.id}"

      click_link "Delete Item"

      expect(current_path).to eq("/items")
      expect { @good_review.reload }.to raise_error ActiveRecord::RecordNotFound
    end

  end
end
