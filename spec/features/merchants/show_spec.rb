require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
      @pull_toy = @bike_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)
      @dog_bone = @bike_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @order_tr = @tire.orders.create(name: "Bob", address: '123 Bob Rd.', city: 'Denver', state: 'CO', zip: "82222")
      @order_pt = @pull_toy.orders.create(name: "Bob", address: '123 Bob Rd.', city: 'Boston', state: 'CO', zip: "82222")
      @order_db = @dog_bone.orders.create(name: "Bob", address: '123 Bob Rd.', city: 'Boston', state: 'CO', zip: "82222")
    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("Show All Items")

      click_on "Show All Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end

    it "I can see stats for a merchant" do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Item Count: 3")
      expect(page).to have_content("Average price of all items: $43.67")
      expect(page).to have_content("List of Cities")
      expect(page).to have_content("Boston")
      expect(page).to have_content("Denver")
    end

    it 'shows flash message when I attempt to visit merchant page that does not exist' do

      visit "merchants/bad_id"

      expect(current_path).to eq("/merchants")

      expect(page).to have_content("The page you have selected does not exist")
    end

  end
end
