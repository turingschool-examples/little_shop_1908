require 'rails_helper'

describe 'Cart Show Page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 2)
  end

  it "displays the items in the cart and other pertinent info" do
    visit "/cart"

    expect(page).to have_content("Your cart is empty, yo.")
    expect(page).to_not have_link("Empty Cart")

    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content("Purchase 1 at $100.00 each")
      expect(page).to have_content("Subtotal: $100.00")
    end

    within "#cart-item-#{@dog_bone.id}" do
      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      expect(page).to have_content(@dog_bone.merchant.name)
      expect(page).to have_content("Purchase 2 at $21.00 each")
      expect(page).to have_content("Subtotal: $42.00")
    end

    expect(page).to have_content("Total Cost: $142.00")
  end

  describe "has a link to add additional items of each item already in the cart" do
    it "that displays a flash message and updates the info and total if successful" do
      visit "/items/#{@tire.id}"

      click_button "Add Item To yo Cart"

      visit "/items/#{@dog_bone.id}"

      click_button "Add Item To yo Cart"

      visit "/items/#{@dog_bone.id}"

      click_button "Add Item To yo Cart"

      visit "/cart"

      within '.topnav' do
        expect(page).to have_link("Items in Cart: 3")
      end

      within "#cart-item-#{@tire.id}" do
        expect(page).to have_link("Add an Additional #{@tire.name}")

        click_link "Add an Additional #{@tire.name}"

        expect(page).to have_content(@tire.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content(@tire.merchant.name)
        expect(page).to have_content("Purchase 2 at $100.00 each")
        expect(page).to have_content("Subtotal: $200.00")
      end

      within '.topnav' do
        expect(page).to have_link("Items in Cart: 4")
      end

      expect(page).to have_content("1 #{@tire.name} has been added. You now have 2 #{@tire.name} in your cart.")
      expect(page).to have_content("Total Cost: $242.00")

      visit "/items/#{@tire.id}"

      expect(page).to have_content("Inventory: 10")
    end

    it "that displays a flash message if unsuccessful" do
      visit "/items/#{@tire.id}"

      click_button "Add Item To yo Cart"

      visit "/items/#{@dog_bone.id}"

      click_button "Add Item To yo Cart"

      visit "/items/#{@dog_bone.id}"

      click_button "Add Item To yo Cart"

      visit "/cart"

      within "#cart-item-#{@dog_bone.id}" do
        expect(page).to have_link("Add an Additional #{@dog_bone.name}")

        click_link "Add an Additional #{@dog_bone.name}"

        expect(page).to have_content(@dog_bone.name)
        expect(page).to have_css("img[src*='#{@dog_bone.image}']")
        expect(page).to have_content(@dog_bone.merchant.name)
        expect(page).to have_content("Purchase 2 at $21.00 each")
        expect(page).to have_content("Subtotal: $42.00")
      end

      within '.topnav' do
        expect(page).to have_link("Items in Cart: 3")
      end

      expect(page).to have_content("Eek! No more #{@dog_bone.name}s left.")
      expect(page).to have_content("Total Cost: $142.00")
    end
  end

  it "has a link to remove a single item from the cart" do
    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_link("Remove a #{@tire.name}")

      click_link "Remove a #{@tire.name}"
    end

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 2")
    end

    expect(page).to_not have_css("#cart-item-#{@tire.id}")
    expect(page).to have_content("Total Cost: $42.00")

    visit "/items/#{@tire.id}"

    expect(page).to have_content("Inventory: 12")

    visit "/cart"

    within "#cart-item-#{@dog_bone.id}" do
      expect(page).to have_link("Remove a #{@dog_bone.name}")

      click_link "Remove a #{@dog_bone.name}"

      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      expect(page).to have_content(@dog_bone.merchant.name)
      expect(page).to have_content("Purchase 1 at $21.00 each")
      expect(page).to have_content("Subtotal: $21.00")
    end

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 1")
    end

    expect(page).to have_content("Total Cost: $21.00")

    visit "/items/#{@dog_bone.id}"

    expect(page).to have_content("Inventory: 1")
  end

  it "has a link to remove all the items of a given type from the cart" do
    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    within "#cart-item-#{@dog_bone.id}" do
      expect(page).to have_link("Remove all #{@dog_bone.name}s")

      click_link "Remove all #{@dog_bone.name}s"
    end

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 1")
    end

    expect(page).to_not have_css("#cart-item-#{@dog_bone.id}")
    expect(page).to have_content("Total Cost: $100.00")

    visit "/items/#{@dog_bone.id}"

    expect(page).to have_content("Inventory: 2")

    visit "/cart"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_link("Remove all #{@tire.name}s")

      click_link "Remove all #{@tire.name}s"
    end

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 0")
    end

    expect(page).to_not have_css("#cart-item-#{@tire.id}")
    expect(page).to have_content("Your cart is empty, yo.")

    visit "/items/#{@tire.id}"

    expect(page).to have_content("Inventory: 12")
  end

  it "has a link to empty the cart" do
    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    expect(page).to have_link("Empty Cart")

    click_link "Empty Cart"

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 0")
    end

    expect(page).to have_content("Your cart is empty, yo.")
    expect(page).to_not have_link("Empty Cart")

    visit "/items/#{@tire.id}"

    expect(page).to have_content("Inventory: 12")

    visit "/items/#{@dog_bone.id}"

    expect(page).to have_content("Inventory: 2")
  end

  it "has a button to check out" do
    visit '/cart'

    expect(page).to_not have_button("Checkout")

    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    expect(page).to have_button("Checkout")

    click_button "Checkout"

    expect(current_path).to eq('/cart/checkout')
  end
end
