require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  it 'shows item info' do
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    review_1 = chain.reviews.create(title: 'Its Great!', content: 'Best chain ever!', rating: 5)
    review_2 = chain.reviews.create(title: 'Its awful!', content: 'I hate it!', rating: 1)
    reviews = chain.reviews.to_a

    visit "items/#{chain.id}"

    expect(page).to have_link(chain.merchant.name)
    expect(page).to have_content(chain.name)
    expect(page).to have_content(chain.description)
    expect(page).to have_content("Price: $#{chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{chain.inventory}")
    expect(page).to have_content("Sold by: #{bike_shop.name}")
    expect(page).to have_css("img[src*='#{chain.image}']")

    within '.reviews-section' do
      reviews.each do |review|
        within "#review-#{review.id}" do
          expect(page).to have_content(review.title)
          expect(page).to have_content(review.content)
          expect(page).to have_content("Rating: #{review.rating}")
        end
      end
    end
    
  end
end
