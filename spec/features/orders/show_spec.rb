require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit order show page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @cart = Cart.new({})
    end

    it "it shows new order that has been created" do
      visit "/items/#{@tire.id}"

      within "#item-info" do
        click_on "Add to Cart"
        @cart.add_item(@tire.id)
      end

      visit "/cart"

      click_link("Checkout")

      expect(current_path).to eq('/orders/new')

      name = "Sal Espinoza"
      address = '123 Kindalikeapizza Dr.'
      city = "Denver"
      state = "CO"
      zip = "80204"

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      expect(page).to have_button("Submit Order")

      click_button("Submit Order")

      new_order = Order.last

      expect(current_path).to eq("/orders/#{new_order.id}")

      quantity_tire = 1

      subtotal_tire = @tire.price * quantity_tire
      grand_total = subtotal_tire

      expect(page).to have_content("Thanks, #{new_order.name}!")
      expect(page).to have_content(@tire.name)
      expect(page).to have_content("Sold by: #{@tire.merchant.name}")
      expect(page).to have_content("Price: $#{@tire.price}")
      expect(page).to have_content("Quantity: #{quantity_tire}")
      expect(page).to have_content("Subtotal: $#{subtotal_tire}")
      expect(page).to have_content("Grand Total: $#{grand_total}")
      expect(page).to have_content("The following order that was placed on #{new_order.created_at.strftime("%Y-%m-%d")} will be shipped to #{new_order.address}")
    end

    it 'it shows flash message when I attempt to visit order page that does not exist' do

      visit "orders/bad_id"

      expect(current_path).to eq("/")

      expect(page).to have_content("The page you have selected does not exist")
    end
  end
end
