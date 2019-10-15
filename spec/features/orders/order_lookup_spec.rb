require 'rails_helper'

RSpec.describe "As a user" do
  describe "I see a search field in the nav bar on any page" do
    it "When I type my verification code into the field, I can look up my order" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      cart = Cart.new({})
      cart.add_item(tire.id)
      cart.add_item(tire.id)
      cart.add_item(chain.id)
      order = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: "a12345678z")
      order.generate_item_orders(cart)

      visit '/merchants'

      expect(page).to have_content("")

      #fill in the search bar

      #click something or press enter

      expect(current_path).to eq("/verified_order/#{order.id}")

      expect(page).to have_content(order.name)
      expect(page).to have_content(order.address)
      expect(page).to have_content(order.city)
      expect(page).to have_content(order.state)
      expect(page).to have_content(order.zip)
    end
  end

end
