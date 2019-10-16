require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I navigate to the order edit page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      cart = Cart.new({})
      cart.add_item(@tire.id)
      cart.add_item(@tire.id)
      cart.add_item(@chain.id)
      @order = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: "a12345678z")
      @order.generate_item_orders(cart)
      visit "/verified_order/#{@order.id}/edit"
    end

    it "I can use the fields I see to update my shipping information" do
      fill_in :name, with: "Joe"
      fill_in :address, with: "234 Road"
      fill_in :city, with: "Dallas"
      fill_in :state, with: "TX"
      fill_in :zip, with: "75070"

      click_button 'Update Shipping Information'

      expect(page).to have_content("Your changes have been saved!")

      fill_in 'search', with: 'a12345678z'
      click_button 'Search'

      expect(page).to have_content("Joe")
      expect(page).to have_content("234 Road")
      expect(page).to have_content("Dallas")
      expect(page).to have_content("TX")
      expect(page).to have_content("75070")
    end

    it "If I leave fields blank, I see an error message" do
      fill_in :name, with: ""
      fill_in :address, with: ""
      fill_in :city, with: ""
      fill_in :state, with: ""
      fill_in :zip, with: ""

      click_button 'Update Shipping Information'

      expect(page).to have_content("Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, and Zip can't be blank")
    end

    it "I can use the buttons I see to remove an item from my order" do
      within "#item-#{@tire.id}" do
        expect(page).to have_button("Remove Item")
        click_button 'Remove Item'
      end

      expect(page).to_not have_css("#item-#{@tire.id}")
      expect(page).to have_content("Your changes have been saved!")
    end

    it "If I remove the last item from my order, my order is deleted" do
      within "#item-#{@tire.id}" do
        expect(page).to have_button("Remove Item")
        click_button 'Remove Item'
      end

      within "#item-#{@chain.id}" do
        expect(page).to have_button("Remove Item")
        click_button 'Remove Item'
      end

      expect(current_path).to eq("/merchants")
      expect(page).to have_content("The last item in your order was deleted, so your order has been deleted.")

      fill_in 'search', with: 'a12345678z'
      click_button 'Search'

      expect(page).to have_content("That order could not be found. Please ensure you have entered the correct verification code.")

    end

    it "I can click a button to delete my order" do
      click_button 'Delete Order'

      expect(current_path).to eq("/merchants")
      expect(page).to have_content("Your order has successfully been deleted.")

      fill_in 'search', with: 'a12345678z'
      click_button 'Search'

      expect(page).to have_content("That order could not be found. Please ensure you have entered the correct verification code.")
    end

  end
end
