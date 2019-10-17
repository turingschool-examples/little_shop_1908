require 'rails_helper'

RSpec.describe 'create item review' do

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  
    visit "/items/#{@chain.id}"

    click_link 'Create Review'
  end

  it 'can add a review by filling out a form' do

    expect(page).to have_link(@chain.name)
    expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

    fill_in :title, with: 'Great chain!'
    fill_in :content, with: 'Would highly recommend. Has never failed me in over ten years.'
    fill_in :rating, with: 5

    click_button 'Create Review'

    expect(current_path).to eq("/items/#{@chain.id}")
    within "#review-#{Review.last.id}" do
      expect(page).to have_content('Great chain!')
      expect(page).to have_content('Would highly recommend. Has never failed me in over ten years.')
      expect(page).to have_content('Rating: 5')
    end
  end

  it 'shows a flash message when form is not filled in' do
    click_button 'Create Review'

    expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Content can't be blank")
    expect(page).to have_content("Rating can't be blank")
  end

  it 'shows a flash message when form is filled improperly' do
    fill_in :rating, with: "Al"
    click_button 'Create Review'

    expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
    expect(page).to have_content('Rating is not a number')
  end
end
