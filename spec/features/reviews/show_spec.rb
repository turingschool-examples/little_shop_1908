require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the items show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @pull_toy = @bike_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @good_review = @chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
      @average_review = @chain.reviews.create(title: "So-so product", content: "This is okay.", rating: 3)
      @negative_review = @chain.reviews.create(title: "I don't like this product", content: "This is not a great product. I will not buy it again soon.", rating: 2)
      @terrible_review = @chain.reviews.create(title: "I hate it", content: "Never buy it again.", rating: 1)
    end

    it 'it shows review stats' do
      visit "/items/#{@chain.id}"

      within "#item-#{@chain.id}-review-stats" do
        expect(page).to have_content("Average Rating")
        expect(page).to have_css('span', :class => 'glyphicon-star')
      end

      within "#item-#{@chain.id}-top-3-reviews" do
        top_three_title_rating = @chain.reviews.order(:rating).reverse[0..2].pluck(:title, :rating)

        expect(page).to have_content("#{top_three_title_rating[0][0]}")
        expect(page).to have_content("#{top_three_title_rating[1][0]}")
        expect(page).to have_css('span', :class => 'glyphicon-star')
      end




      within "#item-#{@chain.id}-bottom-3-reviews" do
        bottom_three_title_rating = @chain.reviews.order(:rating)[0..2].pluck(:title, :rating)

        expect(page).to have_content("#{bottom_three_title_rating[0][0]}")
        expect(page).to have_content("#{bottom_three_title_rating[1][0]}")
        expect(page).to have_css('span', :class => 'glyphicon-star')
      end
    end

    it 'it shows message when no reviews have been posted yet' do
      visit "/items/#{@pull_toy.id}"

      expect(page).to have_content("There are no reviews yet")
    end

  end
end
