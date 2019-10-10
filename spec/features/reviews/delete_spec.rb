require 'rails_helper'

describe 'On an items show page, I see a button next to each review to Delete' do
  describe 'I click the button to delete.'
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
       @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

       @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
       @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

       @review_1 = @chain.reviews.create(title: 'Leiya', content: 'Awful chain, Meeg lied to me!', rating: 1)
       @review_2 = @chain.reviews.create(title: 'Josh', content: "It wasn't that bad.", rating: 2)
       @review_3 = @chain.reviews.create(title: 'John', content: "I don't know why I bought a chain, I don't even use my bike", rating: 3)
    end

    it 'Im returned to the item show page and no longer see the review.' do

      visit "/items/#{@chain.id}"
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.content)
      expect(page).to have_content(@review_2.rating)

      within "#review-#{@review_1.id}" do
        click_on 'Delete Review'
      end

      within "#review-#{@review_2.id}" do
        click_on 'Delete Review'
      end

      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to_not have_content(@review_1.title)
      expect(page).to_not have_content(@review_1.content)
      expect(page).to_not have_content(@review_1.rating)
      expect(page).to_not have_content(@review_2.title)
      expect(page).to_not have_content(@review_2.content)
      expect(page).to_not have_content(@review_2.rating)
    end
end
