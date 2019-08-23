require 'rails_helper'

RSpec.describe "Updating Cart" do
  describe "should empty the cart" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      expect(page).to have_content("Cart: 0")
    end
    it "When I have items in my cart and I visit my cart, next to each item in my cart, I see a button or link to remove that item from my cart" do
      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"
      visit "/cart"
      within "#item-#{@chain.id}" do
        expect(page).to have_button("Remove From Cart")
      end
      within "#item-#{@tire.id}" do
        expect(page).to have_button("Remove From Cart")
      end
    end

    it "Clicking this button will remove the item but not other items" do
      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"
      visit "/cart"
      within "#item-#{@chain.id}" do
        click_button("Remove From Cart")
      end
      expect(page).not_to have_content(@chain.name)
      within "#item-#{@tire.id}" do
        click_button("Remove From Cart")
      end
      expect(page).not_to have_content(@tire.name)
    end
  end
end
