require 'rails_helper'

describe 'Verified Order Show Page' do
  before(:each) do
    @bikey_shop = Merchant.create(name: "Evette's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @doggy_shop = Merchant.create(name: "Evette's Dog Shop", address: '123 Dog Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bikey_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @doggy_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @order = Order.create(name: "Evette", address: "123 street", city: "Denver", state: "CO", zip: 12345)
    @io_1 = @order.item_orders.create(item_id: @tire.id, order_id: @order.id, quantity: 5, total_cost: (@tire.price * 5))
    @io_2 = @order.item_orders.create(item_id: @pull_toy.id, order_id: @order.id, quantity: 2, total_cost: (@pull_toy.price * 2))
  end

  it "displays order info" do
    visit "/merchants"

    within "#order-check" do
      expect(page).to have_button("Check Order")
      fill_in :order_key, with: "12345"
      click_button "Check Order"
    end

    expect(current_path).to eq("/merchants")
    expect(page).to have_content("That order doesn't exist")

    within "#order-check" do
      fill_in :order_key, with: "#{@order.order_key}"
      click_button "Check Order"
    end

    expect(current_path).to eq("/verified_orders")
    expect(page).to have_link(@tire.name)
    expect(page).to have_css("img[src*='#{@tire.image}']")
    expect(page).to have_link(@tire.merchant.name)
    expect(page).to have_content("Purchase 5 at $100.00 each")
    expect(page).to have_content("Subtotal: $500.00")

    expect(page).to have_link(@pull_toy.name)
    expect(page).to have_css("img[src*='#{@pull_toy.image}']")
    expect(page).to have_link(@pull_toy.merchant.name)
    expect(page).to have_content("Purchase 2 at $10.00 each")
    expect(page).to have_content("Subtotal: $20.00")

    expect(page).to have_content("Total Cost: $520.00")
  end

  it "has a form to update shipping information" do
    visit "/merchants"

    within "#order-check" do
      fill_in :order_key, with: "#{@order.order_key}"
      click_button "Check Order"
    end

    expect(find_field('Name').value).to eq(@order.name)
    expect(find_field('Address').value).to eq(@order.address)
    expect(find_field('City').value).to eq(@order.city)
    expect(find_field('State').value).to eq(@order.state)
    expect(find_field('Zip').value).to eq(@order.zip)

    name = "Pug Lover"
    address = "3515 Ringsby Court"
    city = "Denver"
    state = "CO"
    zip = 80216

    fill_in :name, with: ""
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Update Order"

    expect(current_path).to eq("/verified_orders")
    expect(page).to have_content("Name can't be blank")

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Update Order"

    expect(current_path).to eq("/verified_orders")
    expect(page).to have_content("Your shipping info has been updated")
  end

  it "has a link to delete the order" do
    visit "/merchants"

    within "#order-check" do
      fill_in :order_key, with: "#{@order.order_key}"
      click_button "Check Order"
    end

    expect(page).to have_link("Cancel This Order")

    click_link "Cancel This Order"

    expect(current_path).to eq("/items")
    expect(page).to have_content("Your order is history!")

    within "#order-check" do
      fill_in :order_key, with: "#{@order.order_key}"
      click_button "Check Order"
    end

    expect(current_path).to eq("/items")
    expect(page).to have_content("That order doesn't exist")
  end

  it "has a link to remove an item from the order" do
    visit "/merchants"

    within "#order-check" do
      fill_in :order_key, with: "#{@order.order_key}"
      click_button "Check Order"
    end

    expect(page).to have_link("Remove all #{@tire.name}")
    expect(page).to have_link("Remove all #{@pull_toy.name}s")

    click_link "Remove all #{@tire.name}"

    expect(current_path).to eq("/verified_orders/#{@order.id}/items/#{@tire.id}/remove-all")

    expect(page).to_not have_link(@tire.name)
    expect(page).to_not have_css("img[src*='#{@tire.image}']")
    expect(page).to_not have_link(@tire.merchant.name)
    expect(page).to_not have_content("Purchase 5 at $100.00 each")
    expect(page).to_not have_content("Subtotal: $500.00")

    expect(page).to have_link(@pull_toy.name)
    expect(page).to have_css("img[src*='#{@pull_toy.image}']")
    expect(page).to have_link(@pull_toy.merchant.name)
    expect(page).to have_content("Purchase 2 at $10.00 each")
    expect(page).to have_content("Subtotal: $20.00")

    expect(page).to have_content("Total Cost: $20.00")
  end
end
