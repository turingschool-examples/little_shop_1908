require 'rails_helper'

RSpec.describe 'As a visitor' do
  before(:each) do
    bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    @tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 50.00, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 25.05, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 50.00, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 4)

    2.times do
      visit "items/#{@tire.id}"
      click_button 'Add to Cart'
    end

    visit "items/#{@chain.id}"
    click_button 'Add to Cart'

    3.times do
      visit "items/#{@shifter.id}"
      click_button 'Add to Cart'
    end
    visit "/cart"

    click_button 'Proceed to checkout'

    fill_in 'Name', with: 'Richy Rich'
    fill_in 'Address', with: "102 Main Street"
    fill_in 'City', with: "New York"
    fill_in 'State', with: "New York"
    fill_in 'Zip', with: "10221"
    click_button 'Create Order'

    @order = Order.last

    fill_in 'Order Verification Number', with: Order.codes.key(@order.id)

    click_button 'Submit'
  end
  it 'displays all order information with links to delete items, delete the order, and edit the order' do
    within "#ship_to" do
      expect(page).to have_content('Ship to:')
      expect(page).to have_content('Richy Rich')
      expect(page).to have_content('102 Main St')
      expect(page).to have_content('New York')
      expect(page).to have_content('New York')
      expect(page).to have_content('10221')
    end


    within "#item-#{@tire.id}" do
      expect(page).to have_content('Gatorskins')
      expect(page).to have_content("Sold by: Meg's Bike Shop")
      expect(page).to have_content('Price: $50.00')
      expect(page).to have_content('Quantity: 2')
      expect(page).to have_content('Subtotal: $100.00')
    end

    within "#item-#{@chain.id}" do
      expect(page).to have_content('Chain')
      expect(page).to have_content("Sold by: Meg's Bike Shop")
      expect(page).to have_content('Price: $25.05')
      expect(page).to have_content('Quantity: 1')
      expect(page).to have_content('Subtotal: $25.05')
    end

    within "#item-#{@shifter.id}" do
      expect(page).to have_content('Shimano Shifters')
      expect(page).to have_content("Sold by: Meg's Bike Shop")
      expect(page).to have_content('Price: $50.00')
      expect(page).to have_content('Quantity: 3')
      expect(page).to have_content('Subtotal: $150.00')
    end

    expect(page).to have_content('Your order total: $275.05')
    # expect(page).to have_content('Date order was placed: 10/16/2019')
    expect(current_path).to eq("/orders/#{@order.id}/verified_order")
    expect(page).to have_link('Delete Order')
    expect(page).to have_link('Edit Order')
  end
  it 'I can delete the order by clicking the delete order link' do
    click_link 'Delete Order'

    expect(current_path).to eq('/')

    fill_in 'Order Verification Number', with: Order.codes.key(@order.id)

    click_button 'Submit'

    expect(page).to have_content('Order not found. Please try again.')
    expect(current_path).to eq('/')
  end
  it 'I can see the edit page of the order by clicking the edit order link' do
    click_link 'Edit Order'

    expect(current_path).to eq("/orders/#{@order.id}/edit")

    expect(find_field('Name').value).to eq('Richy Rich')
    expect(find_field('Address').value).to eq("102 Main Street")
    expect(find_field('City').value).to eq("New York")
    expect(find_field('State').value).to eq("New York")
    expect(find_field('Zip').value).to eq('10221')
  end
  it 'I can edit the order by filling the fields and clicking update order' do
    click_link 'Edit Order'

    expect(current_path).to eq("/orders/#{@order.id}/edit")

    fill_in 'Name', with: 'Faloola Geller'
    fill_in 'Address', with: "6876 State St"
    fill_in 'City', with: "Buffalo"
    fill_in 'State', with: "New York"
    fill_in 'Zip', with: "10654"
    click_button 'Update Order'

    expect(current_path).to eq("/orders/#{@order.id}")
    expect(page).to have_content('Faloola Geller')
    expect(page).to have_content('6876 State St')
    expect(page).to have_content('Buffalo')
    expect(page).to have_content('New York')
    expect(page).to have_content('10654')
  end
  it 'I can delete items from the order' do
    within "#item-#{@tire.id}" do
      click_link 'Delete Item'
    end

    expect(page).to_not have_css("#item-#{@tire.id}")
  end

end
