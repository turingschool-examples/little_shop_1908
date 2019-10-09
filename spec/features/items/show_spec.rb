require 'rails_helper'

RSpec.describe 'item show page', type: :feature do

  before :each do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @great = @tire.reviews.create(title: 'Great tire.', content: 'Really fills up.', rating: 4)
    @less_than_ideal = @tire.reviews.create(title: 'Less than ideal', content: 'Popped', rating: 1)
    @not_round = @tire.reviews.create(title: 'Not quite round', content: 'Really close though', rating: 3)
    @wrong_size = @tire.reviews.create(title: 'Not the right size', content: 'Misleading description', rating: 1)
    @awesome = @tire.reviews.create(title: 'Awesome', content: 'Love this tire!', rating: 5)

    visit "/items/#{@tire.id}"
  end

  it 'shows item info' do
    expect(page).to have_link(@tire.merchant.name)
    expect(page).to have_content(@tire.name)
    expect(page).to have_content(@tire.description)
    expect(page).to have_content("Price: $#{@tire.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@tire.inventory}")
    expect(page).to have_content("Sold by: #{@meg.name}")
    expect(page).to have_css("img[src*='#{@tire.image}']")
  end

  it "shows all review titles, contents, and ratings" do
    within "#review-#{@great.id}" do
      expect(page).to have_content(@great.title)
      expect(page).to have_content(@great.content)
      expect(page).to have_content("Rating: #{@great.rating}")
    end

    within "#review-#{@wrong_size.id}" do
      expect(page).to have_content(@wrong_size.title)
      expect(page).to have_content(@wrong_size.content)
      expect(page).to have_content("Rating: #{@wrong_size.rating}")
    end

    expect(page).to have_css("#review-#{@less_than_ideal.id}")
    expect(page).to have_css("#review-#{@not_round.id}")
    expect(page).to have_css("#review-#{@awesome.id}")
  end

  it 'shows titles and ratings of top three reviews' do
    within "#top-review-#{@awesome.id}" do
      expect(page).to have_content(@awesome.title)
      expect(page).to have_content("Rating: #{@awesome.rating}")
    end

    within "#top-review-#{@great.id}" do
      expect(page).to have_content(@great.title)
      expect(page).to have_content("Rating: #{@great.rating}")
    end

    within "#top-review-#{@not_round.id}" do
      expect(page).to have_content(@not_round.title)
      expect(page).to have_content("Rating: #{@not_round.rating}")
    end
  end

  it 'shows titles and ratings of bottom three reviews' do
    within "#bottom-review-#{@less_than_ideal.id}" do
      expect(page).to have_content(@less_than_ideal.title)
      expect(page).to have_content("Rating: #{@less_than_ideal.rating}")
    end

    within "#bottom-review-#{@wrong_size.id}" do
      expect(page).to have_content(@wrong_size.title)
      expect(page).to have_content("Rating: #{@wrong_size.rating}")
    end

    within "#bottom-review-#{@not_round.id}" do
      expect(page).to have_content(@not_round.title)
      expect(page).to have_content("Rating: #{@not_round.rating}")
    end
  end

  it 'shows the average review rating' do
    expect(page).to have_content("Average Review Rating: 2.8")
  end

  it 'cannot view an item show page that does not exist' do
    visit '/items/99999'

    expect(page).to have_content('Item does not exist')
    expect(current_path).to eq('/items')
  end
end
