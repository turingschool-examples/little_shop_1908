require 'rails_helper'

RSpec.describe 'cart show page' do
  describe 'when I visit my cart' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit "/items/#{@tire.id}"
      click_button 'Add Item to Cart'

      visit "/items/#{@pull_toy.id}"
      click_button 'Add Item to Cart'

      visit "/items/#{@dog_bone.id}"
      click_button 'Add Item to Cart'

      visit "/items/#{@tire.id}"
      click_button 'Add Item to Cart'

      visit '/cart'
    end

    it 'should show all products and product info' do
      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_css("img[src='#{@tire.image}']")
        expect(page).to have_content("Merchant: #{@tire.merchant.name}")
        expect(page).to have_content("Price: $100.00")
        expect(page).to have_content("Quantity: 2")
        expect(page).to have_content("Subtotal: $200.00")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_content(@pull_toy.name)
        expect(page).to have_css("img[src='#{@pull_toy.image}']")
        expect(page).to have_content("Merchant: #{@pull_toy.merchant.name}")
        expect(page).to have_content("Price: $10.00")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: $10.00")
      end

      within "#item-#{@dog_bone.id}" do
        expect(page).to have_content(@dog_bone.name)
        expect(page).to have_css("img[src='#{@dog_bone.image}']")
        expect(page).to have_content("Merchant: #{@dog_bone.merchant.name}")
        expect(page).to have_content("Price: $21.00")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: $21.00")
      end
    end

    it 'should show the total of all item subtotals' do
      expect(page).to have_content("Grand Total: $231.00")
    end

    it 'should remove all items from cart after clicking empty cart' do
      click_button 'Empty Cart'

      expect(current_path).to eq('/cart')
      expect(page).to_not have_css "#item-#{@tire.id}"
      expect(page).to_not have_css "#item-#{@pull_toy.id}"
      expect(page).to_not have_css "#item-#{@dog_bone.id}"

      within('nav') { expect(page).to have_content('Cart (0)') }
    end

    it 'should display empty cart if there are not items' do
      click_button 'Empty Cart'

      expect(page).to have_content("Your cart is empty")
    end

    it 'shows a button to remove an item from the cart' do
      within "#item-#{@tire.id}" do
        click_button 'Remove Item'
      end

      expect(page).to_not have_css "#item-#{@tire.id}"
      expect(page).to have_css "#item-#{@pull_toy.id}"
      expect(page).to have_css "#item-#{@dog_bone.id}"
    end

    it 'can increase the quanitity of an item by clicking a button' do
      within "#item-#{@tire.id}" do
        10.times do
          click_link 'Increase Quantity (+1)'
        end

        expect(page).to have_content("Quantity: 12")

        click_link 'Increase Quantity (+1)'
        expect(page).to have_content("Quantity: 12")
      end

      expect(page).to have_content("You have reached the maximum inventory of #{@tire.name}")
    end

    it 'can decrease the quanitity of an item by clicking a button' do
      within "#item-#{@tire.id}" do
        click_link 'Decrease Quantity (-1)'
        expect(page).to have_content("Quantity: 1")

        click_link 'Decrease Quantity (-1)'
      end

      expect(page).to_not have_css("#item-#{@tire.id}")
    end

  end
end
