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

  it 'shows reviews for that item' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    review_1 = pull_toy.reviews.create(title: "This toy rules", content: "I bought this for my dog and it rules", rating: 5)
    review_2 = pull_toy.reviews.create(title: "This toy sucks", content: "My dog hates this toy", rating: 1)

    visit "items/#{pull_toy.id}"

    within "#review-#{pull_toy.id}"
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.content)
      expect(page).to have_content(review_2.rating)
      
  end
end
