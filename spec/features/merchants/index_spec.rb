require 'rails_helper'

describe 'Merchant Index Page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
  end

  it 'has a list of merchants in the system that link to those merchants' do
    visit '/merchants'

    expect(page).to have_link(@bike_shop.name)

    click_link "#{@bike_shop.name}"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}")

    visit '/merchants'

    expect(page).to have_link(@dog_shop.name)

    click_link "#{@dog_shop.name}"

    expect(current_path).to eq("/merchants/#{@dog_shop.id}")
  end

  it 'has a link to create a new merchant' do
    visit '/merchants'

    expect(page).to have_link("New Merchant")

    click_link "New Merchant"

    expect(current_path).to eq("/merchants/new")
  end
end
