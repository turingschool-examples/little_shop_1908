require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end

  it 'shows item info' do
    review_1 = @chain.reviews.create(title: 'Its Great!', content: 'Best chain ever!', rating: 5)
    review_2 = @chain.reviews.create(title: 'Its awful!', content: 'I hate it!', rating: 1)
    review_3 = @chain.reviews.create(title: 'Its not good!', content: 'I would not buy again!', rating: 2)
    review_4 = @chain.reviews.create(title: 'Its meh!', content: 'decent!', rating: 3)
    reviews = @chain.reviews.to_a

    visit "items/#{@chain.id}"

    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")

    within '.reviews-section' do
      reviews.each do |review|
        within "#review-#{review.id}" do
          expect(page).to have_content(review.title)
          expect(page).to have_content(review.content)
          expect(page).to have_content("Rating: #{review.rating}")
        end
      end

      within '.reviews-stats' do
        within '#top-three' do
          expect(page).to have_content(review_1.title)
          expect(page).to have_content(review_3.title)
          expect(page).to have_content(review_4.title)
          expect(page).to_not have_content(review_2.title)
          expect(page).to have_content("(#{review_1.rating}/5)")
          expect(page).to have_content("(#{review_3.rating}/5)")
          expect(page).to have_content("(#{review_4.rating}/5)")
          expect(page).to_not have_content("(#{review_2.rating}/5)")
        end

        within '#bottom-three' do
          expect(page).to have_content(review_2.title)
          expect(page).to have_content(review_3.title)
          expect(page).to have_content(review_4.title)
          expect(page).to_not have_content(review_1.title)
          expect(page).to have_content("(#{review_2.rating}/5)")
          expect(page).to have_content("(#{review_3.rating}/5)")
          expect(page).to have_content("(#{review_4.rating}/5)")
          expect(page).to_not have_content("(#{review_1.rating}/5)")
        end
        within '#avg-rating' do
          expect(page).to have_content("Average Rating: 2.75")
        end
      end
    end
  end

  it "shows alternate reviews header if no reviews" do
    visit "/items/#{@chain.id}"

    within '.reviews-section-header' do
      expect(page).to have_content('Customer Reviews: No reviews yet')
      expect(page).to_not have_css(".dropbtn")
    end
  end
end

describe 'User can use sort by button' do
  it "sorts the reviews" do
    bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    review_1 = tire.reviews.create(title: 'Its Great!', content: 'Best tire ever!', rating: 5)
    review_2 = tire.reviews.create(title: 'Its awful!', content: 'I hate it!', rating: 1)
    review_3 = tire.reviews.create(title: 'Its okay!', content: 'Mediocre at best...', rating: 3)
    review_4 = tire.reviews.create(title: "It's pretty good", content: 'Maybe a little pricey, but they sure work good.', rating: 2)
    review_5 = tire.reviews.create(title: "It's pretty decent", content: 'Lasted a pretty long time on my last set', rating: 4)

    visit "/items/#{tire.id}"

    click_link 'Rating: High - Low'
    # expect(page).to have_current_path(items_path(only_path: true, sort: 'max-rating'))

    click_link 'Rating: Low - High'
    # expect(current_path).to eq("/items/#{tire.id}?sort=min-rating")

    click_link 'Date: Newest First'
    # expect(current_path).to eq("/items/#{tire.id}?sort=date-desc")

    click_link 'Date: Oldest First'
    # expect(current_path).to eq("/items/#{tire.id}?sort=date-asc")
  end
end
