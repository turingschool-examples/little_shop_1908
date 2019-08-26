require 'rails_helper'

describe 'Order New Page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 2)
  end

  it "displays the items in the order and other pertinent info" do
    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    click_button "Checkout"

    expect(current_path).to eq('/cart/checkout')

    within "#order-item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content("Purchase 1 at $100.00 each")
      expect(page).to have_content("Subtotal: $100.00")
    end

    within "#order-item-#{@dog_bone.id}" do
      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      expect(page).to have_content(@dog_bone.merchant.name)
      expect(page).to have_content("Purchase 2 at $21.00 each")
      expect(page).to have_content("Subtotal: $42.00")
    end

    expect(page).to have_content("Total Cost: $142.00")

    name = "Pug Lover"
    address = "123 Kindalikeapugs St."
    city = "Denver"
    state = "CO"
    zip = 80204

    fill_in :name, with: ""
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    expect(page).to have_button("Create Order")

    click_button "Create Order"

    expect(current_path).to eq("/cart/checkout")

    expect(page).to have_content("Enter your shipping info again")

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Create Order"

    new_order = Order.last

    expect(current_path).to eq("/orders/#{new_order.id}")

    within "#order-item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content("Purchase 1 at $100.00 each")
      expect(page).to have_content("Subtotal: $100.00")
    end

    within "#order-item-#{@dog_bone.id}" do
      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      expect(page).to have_content(@dog_bone.merchant.name)
      expect(page).to have_content("Purchase 2 at $21.00 each")
      expect(page).to have_content("Subtotal: $42.00")
    end

    expect(page).to have_content("Total Cost: $142.00")
    expect(page).to have_content("Name: #{name}")
    expect(page).to have_content("Address: #{address}")
    expect(page).to have_content("City: #{city}")
    expect(page).to have_content("State: #{state}")
    expect(page).to have_content("Zip: #{zip}")
    expect(page).to have_content("Created: #{new_order.created_at.strftime("%Y-%m-%d")}")
  end
end
