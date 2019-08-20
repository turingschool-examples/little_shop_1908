require 'rails_helper'

describe 'Merchant Show Page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
  end

  xit "displays a merchant's name, address, city, state, zip" do
    visit "/merchants/#{@bike_shop.id}"
    expect(page).to have_content(@bike_shop.name)
    expect(page).to have_content("#{@bike_shop.address}\n#{@bike_shop.city}, #{@bike_shop.state} #{@bike_shop.zip}")
  end

  xit 'has a link to visit the merchant items' do
    visit "/merchants/#{@bike_shop.id}"
    expect(page).to have_link("All #{@bike_shop.name} Items")
    click_link "All #{@bike_shop.name} Items"
    expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
  end

  describe 'has a link to delete the merchant' do
    xit 'if the merchant has no items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("Delete Merchant")

      click_link "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content(@bike_shop.name)
    end

    xit 'if the merchant has items and no orders' do
      chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("Delete Merchant")

      click_link "Delete Merchant"
      
      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content(@bike_shop.name)
    end
  end
end
