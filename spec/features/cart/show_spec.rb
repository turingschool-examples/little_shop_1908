require 'rails_helper'

describe 'When I visit cart show Page' do
  describe 'I can see all the items in my cart and the grand total cost'
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      # @cart = Cart.new(session[:cart])


    end

    it 'Each item shows its: Name, Price, Image, Selling Merchant, Quantity, Subtotal.' do

      visit "/items/#{@tire.id}"
      click_on "Add to cart"
      visit "/items/#{@tire.id}"
      click_on "Add to cart"
      visit "/items/#{@pull_toy.id}"
      click_on "Add to cart"

      visit "/cart"

      expect(page).to have_content("Grand Total: 210")

      within ".all-cart-items" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_link(@pull_toy.name)
      end

      within "#cart-item-#{@tire.id}" do
        expect(page).to have_link(@tire.merchant.name)
        expect(page).to have_content(@tire.price)
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content("Quantity: 2")
        expect(page).to have_content("Subtotal: 200")
      end

      within "#cart-item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.merchant.name)
        expect(page).to have_content(@pull_toy.price)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: 10")
      end

    end

    it "Tells me when cart is empty, doesn't show link to empty cart" do

      visit '/cart'

      expect(page).to have_content("Your cart is empty")
      expect(page).to have_no_link("Empty cart")

    end

    it "Lets me empty cart" do
      visit "/items/#{@tire.id}"
      click_on "Add to cart"
      visit "/items/#{@tire.id}"
      click_on "Add to cart"
      visit "/items/#{@pull_toy.id}"
      click_on "Add to cart"

      visit "/cart"

      click_on "Empty cart"
      save_and_open_page
      expect(current_path).to eq("/cart")
      expect(page).to have_content("Your cart is empty")
      expect(page).to have_no_link("Empty cart")
    end
end
