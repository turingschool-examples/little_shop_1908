require 'rails_helper'

RSpec.describe "Reviews Index" do
  describe "When I visit the items show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @good_review = @chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
      @average_review = @chain.reviews.create(title: "So-so product", content: "This is okay.", rating: 3)
      @negative_review = @chain.reviews.create(title: "I don't like this product", content: "This is not a great product. I will not buy it again soon.", rating: 2)
      @terrible_review = @chain.reviews.create(title: "I hate it", content: "Never buy it again.", rating: 1)
    end

    it 'shows link to add a new review for item and shows flash messages' do
      visit "/items/#{@chain.id}"
      click_link "add new review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

      title = "So-so product"
      content = "This product was very, very average"
      rating = 3

      fill_in :title, with: title
      fill_in :content, with: content
      fill_in :rating, with: rating

      click_button "Post Review"

      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to have_content("You have successfully posted a review")

      within "#review-#{Review.last.id}" do
        expect(page).to have_content(title)
        expect(page).to have_content(content)
        expect(page).to have_content("Rating: #{rating}")
      end
    end

    it 'shows alert flash messages when form is not completely filled' do
      visit "/items/#{@chain.id}"
      click_link "add new review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

      title = "So-so product"

      fill_in :title, with: title

      click_button "Post Review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      expect(page).to have_content("Content can't be blank and Rating can't be blank")
    end
  end
end
