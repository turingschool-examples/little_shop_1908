require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
    @review_2 = @chain.reviews.create(title: "Awesome chain!", content: "This was a great chain! Would buy again.", rating: 5)
    @review_3 = @chain.reviews.create(title: "Meh", content: "Not the best.", rating: 2)
    @review_4 = @chain.reviews.create(title: "Okay", content: "Got the job done.", rating: 3)
    @review_5 = @chain.reviews.create(title: "Pretty Good", content: "Good chain, would probably buy again.", rating: 4)
    @review_6 = @chain.reviews.create(title: "Best chain EVER!", content: "So amazing, I'm in love.", rating: 5)

    visit "/items/#{@chain.id}"
  end

  it 'shows item info' do
    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")

    expect(page).to have_content('Reviews')
  end

  it 'shows a flash message that the item does not exist if I type an unknown id in the url' do
    visit '/items/35466'

    expect(current_path).to eq('/items')
    expect(page).to have_content('This item does not exist. Please select an existing item.')
  end

  it 'shows list of review for that item' do
    within "#review-#{@review_2.id}" do
      expect(page).to have_content("Awesome chain!")
      expect(page).to have_content("This was a great chain! Would buy again.")
      expect(page).to have_content("Rating: 5")
    end

    within  "#review-#{@review_1.id}" do
      expect(page).to have_content("Worst chain!")
      expect(page).to have_content("NEVER buy this chain.")
      expect(page).to have_content("Rating: 1")
    end

    within  "#review-#{@review_3.id}" do
      expect(page).to have_content("Meh")
      expect(page).to have_content("Not the best.")
      expect(page).to have_content("Rating: 2")
    end

    within  "#review-#{@review_4.id}" do
      expect(page).to have_content("Okay")
      expect(page).to have_content("Got the job done.")
      expect(page).to have_content("Rating: 3")
    end

    within  "#review-#{@review_5.id}" do
      expect(page).to have_content("Pretty Good")
      expect(page).to have_content("Good chain, would probably buy again.")
      expect(page).to have_content("Rating: 4")
    end

    within  "#review-#{@review_6.id}" do
      expect(page).to have_content("Best chain EVER!")
      expect(page).to have_content("So amazing, I'm in love.")
      expect(page).to have_content("Rating: 5")
    end
  end

  it 'shows review statistics' do
    expect(page).to have_content('Review Statistics')

    expect(page).to have_content('Top 3 Reviews')
    within "#top3" do

      expect(page).to have_content('Best chain EVER!')
      expect(page).to have_content('Awesome chain!')
      expect(page).to have_content('Pretty Good')
      expect(page).to have_content('Rating: 5')
      expect(page).to have_content('Rating: 5')
      expect(page).to have_content('Rating: 4')
    end

    expect(page).to have_content('Bottom 3 Reviews')
    within "#bottom3" do

      expect(page).to have_content('Worst chain!')
      expect(page).to have_content('Meh')
      expect(page).to have_content('Okay')
      expect(page).to have_content('Rating: 1')
      expect(page).to have_content('Rating: 2')
      expect(page).to have_content('Rating: 3')
    end

    expect(page).to have_content('Average Rating: 3.33')
  end
end
