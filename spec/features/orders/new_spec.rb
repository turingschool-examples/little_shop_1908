require 'rails_helper'

RSpec.describe "New Order Page" do
  describe "When I visit the new order page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @cart = Cart.new({})
    end

    it "shows new order information and shipping information form" do
      visit "/items/#{@tire.id}"

      within "#item-info" do
        click_on "Add to Cart"
        @cart.add_item(@tire.id)
      end

      visit "/cart"

      click_link("Checkout")

      expect(current_path).to eq('/orders/new')

      quantity_tire = @cart.quantity_of(@tire.id)

      subtotal_tire = @tire.price * quantity_tire
      grand_total = subtotal_tire

      expect(page).to have_content(@tire.name)
      expect(page).to have_content("Sold by: #{@tire.merchant.name}")
      expect(page).to have_content("Price: $#{@tire.price}")
      expect(page).to have_content("Quantity: #{quantity_tire}")
      expect(page).to have_content("Subtotal: $#{subtotal_tire}")

      expect(page).to have_content("Grand Total: $#{grand_total}")

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
    end

    it "shows flash message when shipping information form is incomplete" do

      visit "/items/#{@tire.id}"

      within "#item-info" do
        click_on "Add to Cart"
        @cart.add_item(@tire.id)
      end

      visit "/cart"

      click_link("Checkout")

      expect(current_path).to eq('/orders/new')

      quantity_tire = @cart.quantity_of(@tire.id)

      subtotal_tire = @tire.price * quantity_tire
      grand_total = subtotal_tire

      expect(page).to have_content(@tire.name)
      expect(page).to have_content("Sold by: #{@tire.merchant.name}")
      expect(page).to have_content("Price: $#{@tire.price}")
      expect(page).to have_content("Quantity: #{quantity_tire}")
      expect(page).to have_content("Subtotal: $#{subtotal_tire}")

      expect(page).to have_content("Grand Total: $#{grand_total}")

      name = "Sal Espinoza"
      address = '123 Kindalikeapizza Dr.'
      city = "Denver"
      state = "CO"
      zip = "80204"

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state

      click_on("Submit Order")
      expect(current_path).to eq("/orders/new")
      expect(page).to have_content("The shipping information form is incomplete. Please fill in all five fields in order to submit order.")
    end
  end
end
