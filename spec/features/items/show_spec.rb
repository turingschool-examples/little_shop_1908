require 'rails_helper'

describe 'item show page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @chain_review = @chain.reviews.create(title: 'Awesome Tire', content: 'This tire works well', rating: 5)
    @chain_review_2 = @chain.reviews.create(title: 'Okay Tire', content: 'This tire works', rating: 3)
    @chain_review_3 = @chain.reviews.create(title: 'Bad Tire', content: 'This tire doesnt work', rating: 1)
  end

  it 'shows item info' do
    visit "items/#{@chain.id}"

    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content('Active')
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")

    # can we see review user stopry 4
    expect(page).to have_content("Title: #{@chain_review.title}")
    expect(page).to have_content("Description: #{@chain_review.content}")
    expect(page).to have_content("Rating: #{@chain_review.rating}")
  end

  # can we create review user story 5
  it 'has a link to a form where a new review can be created' do
    visit "/items/#{@chain.id}"
    click_link 'Add Review'
    expect(current_path).to eq("/items/#{@chain.id}/review")
  end

  it 'shows the average rating of an item' do
    visit "/items/#{@chain.id}"

    within '.reviews' do
      expect(page).to have_content("Average Rating: #{@chain.average_rating.round(2)}")
    end
  end

  it 'shows the top 3 reviews' do
    visit  "/items/#{@chain.id}"

    within '#top-three-reviews' do
      expect(page.all('li')[0]).to have_content(@chain_review.title)
      expect(page.all('li')[1]).to have_content(@chain_review_2.title)
      expect(page.all('li')[2]).to have_content(@chain_review_3.title)
    end
  end

  it 'it shows the bottom 3 reviews' do
    visit "/items/#{@chain.id}"

    within '#bottom-three-reviews' do
      expect(page.all('li')[0]).to have_content(@chain_review_3.title)
      expect(page.all('li')[1]).to have_content(@chain_review_2.title)
      expect(page.all('li')[2]).to have_content(@chain_review.title)
    end
  end
end
