require 'rails_helper'

describe 'item show page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @chain_review = @chain.reviews.create(title: 'Awesome Tire', content: 'This tire works well', rating: 5)
    @chain_review_2 = @chain.reviews.create(title: 'Okay Tire', content: 'This tire works', rating: 3)
    @chain_review_3 = @chain.reviews.create(title: 'Bad Tire', content: 'This tire doesnt work', rating: 1)
  end


it 'I can see an index of reviews on the item show page' do
 visit "/items/#{@chain.id}"

   expect(page).to have_content(@chain_review.title)
   expect(page).to have_content(@chain_review.content)
   expect(page).to have_content("Rating: #{@chain_review.rating}")
   expect(page).to have_content(@chain_review_2.title)
   expect(page).to have_content(@chain_review_2.content)
   expect(page).to have_content("Rating: #{@chain_review_2.rating}")
   expect(page).to have_content(@chain_review_3.title)
   expect(page).to have_content(@chain_review_3.content)
   expect(page).to have_content("Rating: #{@chain_review_3.rating}")
end
end
