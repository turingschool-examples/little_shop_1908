require 'rails_helper'

describe "Merchant Items Index Page" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = @bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
  end

  it "has a list of the merchant's items and their info" do
    visit "/merchants/#{@bike_shop.id}/items"

    within "#item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_content("Price: $#{@tire.price}")
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content("Active")
      expect(page).to_not have_content(@tire.description)
      expect(page).to have_content("Inventory: #{@tire.inventory}")
    end

    within "#item-#{@chain.id}" do
      expect(page).to have_content(@chain.name)
      expect(page).to have_content("Price: $#{@chain.price}")
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content("Active")
      expect(page).to_not have_content(@chain.description)
      expect(page).to have_content("Inventory: #{@chain.inventory}")
    end

    within "#item-#{@shifter.id}" do
      expect(page).to have_content(@shifter.name)
      expect(page).to have_content("Price: $#{@shifter.price}")
      expect(page).to have_css("img[src*='#{@shifter.image}']")
      expect(page).to have_content("Inactive")
      expect(page).to_not have_content(@shifter.description)
      expect(page).to have_content("Inventory: #{@shifter.inventory}")
    end
  end

  it 'has links to all item and merchant names' do
    visit "/merchants/#{@bike_shop.id}/items"

    expect(page).to have_link(@tire.name)
    expect(page).to have_link(@tire.merchant.name)
    expect(page).to have_link(@chain.name)
    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_link(@shifter.name)
    expect(page).to have_link(@shifter.merchant.name)
  end

  it 'has a link to add a new item' do
    visit "/merchants/#{@bike_shop.id}/items"

    expect(page).to have_link("Add New Item")

    click_link "Add New Item"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}/items/new")
  end
end
