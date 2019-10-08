require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  describe 'shows item and all reviews for that item'
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: 'Leiya', content: 'Awful chain, Meg lied to me!', rating: 0)
      @review_2 = @chain.reviews.create(title: 'Josh', content: " It wasn't that bad.", rating: 3)
      @review_3 = @chain.reviews.create(title: 'Evette', content: " Great chain! Used it to make an amazing collar for my pug Larry.", rating: 5)
    end

    it 'shows item info' do
      visit "items/#{@chain.id}"

      expect(page).to have_link(@chain.merchant.name)
      expect(page).to have_content(@chain.name)
      expect(page).to have_content(@chain.description)
      expect(page).to have_content("Price: $#{@chain.price}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@chain.inventory}")
      expect(page).to have_content("Sold by: #{@bike_shop.name}")
      expect(page).to have_css("img[src*='#{@chain.image}']")
    end

    it 'shows a list of reviews with title, content, and rating' do
      visit "items/#{@chain.id}"

      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_3.title)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_content(@review_2.content)
      expect(page).to have_content(@review_3.content)
      expect(page).to have_content("Rating: #{@review_1.rating}")
      expect(page).to have_content("Rating: #{@review_2.rating}")
      expect(page).to have_content("Rating: #{@review_3.rating}")
    end
end
