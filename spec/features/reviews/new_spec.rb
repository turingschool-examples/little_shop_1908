require 'rails_helper'

RSpec.describe "Review new page" do
  describe "As a user, when I visit an item's show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "/items/#{@chain.id}"
    end

    it "I see a button to create a review for that item" do
      expect(page).to have_button('Add Review')
    end

    it "After clicking the button, I can create a new review for that item" do
      click_button ('Add Review')

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      expect(page).to have_link(@chain.name)

      fill_in :title, with: "Love It!"
      fill_in :content, with: "I'd buy it again, totally fixed my bike issues!"
      fill_in :rating, with: 5

      click_button('Create Review')

      expect(current_path).to eq("/items/#{@chain.id}")

      within "#review-#{@chain.reviews[0].id}" do
        expect(page).to have_content("Love It!")
        expect(page).to have_content("I'd buy it again, totally fixed my bike issues!")
        expect(page).to have_content(5)
      end
    end

    it "Can't create a review without a title, content, a non-numerical rating, or a rating outside of 1 to 5" do
      click_button ('Add Review')
      click_button ('Create Review')

      expect(page).to have_content("Title can't be blank, Content can't be blank, Rating can't be blank, and Rating is not a number")
      expect(page).to have_button('Create Review')

      fill_in :rating, with: 7
      click_button ('Create Review')

      expect(page).to have_content("Title can't be blank, Content can't be blank, and Rating must be less than or equal to 5")
    end
  end
end
