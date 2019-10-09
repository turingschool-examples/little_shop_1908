require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit an items show page' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @review_1 = @chain.reviews.create(title: "Best Chain!", content: "It never broke!", rating: 5)
      visit "/items/#{@chain.id}"
    end

    it "has a button to delete the review" do
      within "#item-review-#{@review_1.id}" do
        click_button "Delete Review"
      end
      
      expect(page).to_not have_css("#item-review-#{@review_1.id}")
    end
  end
end