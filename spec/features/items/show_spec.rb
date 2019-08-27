require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  it 'shows item info' do
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "items/#{chain.id}"

    expect(page).to have_link(chain.merchant.name)
    expect(page).to have_content(chain.name)
    expect(page).to have_content(chain.description)
    expect(page).to have_content("Price: $#{chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{chain.inventory}")
    expect(page).to have_content("Sold by: #{bike_shop.name}")
    expect(page).to have_css("img[src*='#{chain.image}']")
  end

  it 'shows a list of reviews' do
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    review_1 = chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
    review_2 = chain.reviews.create!(title: "Ew", content: "The worst", rating: 1)

    visit "items/#{chain.id}"

    within "#review-#{review_1.id}" do
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content("Rating: #{review_1.rating}")
    end

    within "#review-#{review_2.id}" do
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.content)
      expect(page).to have_content("Rating: #{review_2.rating}")
    end
  end

  it "I see an area on the page for statistics about reviews" do
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    review_1 = chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
    review_2 = chain.reviews.create!(title: "Win!", content: "It IS a chain!!", rating: 5)

    review_3 = chain.reviews.create!(title: "Yay", content: "I can ride my bike now!", rating: 5)
    review_4 = chain.reviews.create!(title: "No Way!", content: "The worst", rating: 1)

    review_5 = chain.reviews.create!(title: "Not Mad, Just Disappointed", content: "I just want to ride my bicycle", rating: 2)
    review_6 = chain.reviews.create!(title: "Womp Womp", content: "I hate it", rating: 1)

    visit "items/#{chain.id}"

      expect(page).to have_content("Item Statistics")
      expect(page).to have_content("Top Three Reviews")
        within "#top-reviews" do
          expect(page).to have_content(review_1.title)
          expect(page).to have_content(review_2.title)
          expect(page).to have_content(review_3.title)

          expect(page).to have_content(review_1.rating)
          expect(page).to have_content(review_2.rating)
          expect(page).to have_content(review_3.rating)
        end
      expect(page).to have_content("Bottom Three Reviews")
        within "#bottom-reviews" do
          expect(page).to have_content(review_4.title)
          expect(page).to have_content(review_5.title)
          expect(page).to have_content(review_6.title)

          expect(page).to have_content(review_4.rating)
          expect(page).to have_content(review_5.rating)
          expect(page).to have_content(review_6.rating)
        end
      expect(page).to have_content("Average Rating: 3")
  end
  it "I see additional links to sort their reviews in the following ways
      - sort reviews by highest rating, then by descending date
      - sort reviews by lowest rating, then by ascending date" do
  bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
  chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  review_1 = chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 5)
  review_2 = chain.reviews.create!(title: "Win!", content: "It IS a chain!!", rating: 4)

  review_3 = chain.reviews.create!(title: "Yay", content: "I can ride my bike now!", rating: 3)
  review_4 = chain.reviews.create!(title: "No Way!", content: "The worst", rating: 2)

  review_5 = chain.reviews.create!(title: "Not Mad, Just Disappointed", content: "I just want to ride my bicycle", rating: 1)

  visit "items/#{chain.id}"

  click_on 'Sort By Highest Rating'

  expect(current_path).to eq("/items/#{chain.id}")

  end
end
