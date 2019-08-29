require 'rails_helper'

RSpec.describe "Order show" do
  describe "as a visitor" do
    before(:each) do
       @scott = Merchant.create!(name: 'scotts games', address: '842 g st', city: 'Denver', state: 'CO', zip: 80011)
       @vg_1 = @scott.items.create!(name: 'halo 3', description: "Halo 3 for XBOX360", price: 40, image: 'https://images-na.ssl-images-amazon.com/images/I/81JHQU3xX-L._SY679_.jpg', active?: true, inventory: 5 )
       @vg_2 = @scott.items.create!(name: 'smash bros', description: "Smash for wii ", price: 50, image: 'https://images-na.ssl-images-amazon.com/images/I/81aJ-R4E6gL._AC_SX430_.jpg', active?: true, inventory: 3 )
     end

    it "shows my created order and all its info" do

      visit "/items/#{@vg_1.id}"
      click_button 'Add Item'

      visit "/items/#{@vg_2.id}"
      click_button 'Add Item'

      visit '/cart'

      click_button "Checkout"

      expect(current_path).to eq('/orders/new')

    name = "Scott Payton"
    address = '111 cool st'
    city = "Denver"
    state = "CO"
    zip = 80011

      within '#shipping' do
        fill_in "Username", with: name
        fill_in "Address", with: address
        fill_in "City", with: city
        fill_in "State", with: state
        fill_in "Zipcode", with: zip
      end

      click_button "Create Order"

      order = Order.last

      expect(current_path).to eq("/orders/#{order.id}")

      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(city)
      expect(page).to have_content(state)
      expect(page).to have_content(zip)

      expect(page).to have_content(@vg_2.name)
      expect(page).to have_content(@vg_1.name)
      expect(page).to have_content(@vg_2.merchant.name)
      expect(page).to have_content(@vg_1.merchant.name)
      expect(page).to have_content(@vg_2.price)
      expect(page).to have_content(@vg_1.price)
      expect(page).to have_content("Amount: 1")
      expect(page).to have_content("Amount: 1")
      expect(page).to have_content("Subtotal: $40.00")
      expect(page).to have_content("Subtotal: $50.00")
      expect(page).to have_content("Total: $90.00")
      expect(page).to have_content(order.created_at)
    end

    it "flashes a message if missing information" do

      name = 'scott'
      address = '111 cool st'
      city = 'aurora'
      state = 'CO'
      zip = '80011'

      visit "/items/#{@vg_1.id}"
      click_button 'Add Item'

      visit "/items/#{@vg_2.id}"
      click_button 'Add Item'

      visit "/items/#{@vg_2.id}"
      click_button 'Add Item'

      visit '/cart'

      click_button "Checkout"


        fill_in "Username", with: name
        fill_in "Address", with: address
        fill_in "City", with: city
        fill_in "Zip", with: zip
      # end
      click_button "Create Order"
      expect(page).to have_content("No fields can be blank.")
    end
end
 end
