require 'rails_helper'

RSpec.describe 'Cart show page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
    @chain = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 2)
    @tire = @bike_shop.items.create!(name: 'Tire', description: 'This is a tire.', price: 30, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 7)
  end
  it 'shows info of all items in cart with grand total' do
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add Item to Cart'

    visit '/cart'

    within "#cart-#{@chain.id}" do
      expect(page).to have_content(@chain.name)
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content(@chain.merchant.name)
      expect(page).to have_content(@chain.price)
      expect(page).to have_content('Count: 1')
      expect(page).to have_content('Subtotal: $50.00')
    end

    within "#cart-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content(@tire.price)
      expect(page).to have_content('Count: 1')
      expect(page).to have_content('Subtotal: $30.00')
    end

    expect(page).to have_content('Grand Total: $80.00')
  end

  it 'shows empty page with message if cart is empty' do
    visit '/cart'

    expect(page).to have_content('Your cart is currently empty')

    expect(page).to_not have_link('Empty Cart')
  end

  it 'has link and can empty cart' do
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add Item to Cart'

    visit '/cart'

    click_link 'Empty Cart'

    expect(current_path).to eq('/cart')

    expect(page).to_not have_content(@chain.name)
    expect(page).to_not have_css("img[src*='#{@chain.image}']")
    expect(page).to_not have_content(@chain.merchant.name)
    expect(page).to_not have_content(@chain.price)
    expect(page).to_not have_content('Count: 1')
    expect(page).to_not have_content('Subtotal: $50.00')

    expect(page).to have_link('Cart (0)')
  end

  it 'can remove a single item from the cart' do
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add Item to Cart'

    visit '/cart'

    within "#cart-#{@chain.id}" do
      click_link 'Delete Item'
    end

    expect(current_path).to eq('/cart')

    within "#cart-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content(@tire.price)
      expect(page).to have_content('Count: 1')
      expect(page).to have_content('Subtotal: $30.00')
    end

    expect(page).to_not have_content(@chain.name)
    expect(page).to_not have_content(@chain.price)
    expect(page).to_not have_content('Subtotal: $50.00')
  end

  it 'I see a link to increment the count of items. I cannot increment beyond the item inventory size.' do
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'

    visit '/cart'

    within "#cart-#{@chain.id}" do
      click_link '+'
    end

    expect(current_path).to eq('/cart')

    within "#cart-#{@chain.id}" do
      expect(page).to have_content('Count: 2')
      expect(page).to_not have_link('+')
    end
  end

  it 'I see a link to decrement the count of items. If I decrement the count to 0 the item is immediately removed from my cart.' do
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'

    visit '/cart'

    within "#cart-#{@chain.id}" do
      click_link '-'
    end

    expect(current_path).to eq('/cart')

    expect(page).to_not have_content(@chain.name)
    expect(page).to_not have_content(@chain.description)
    expect(page).to_not have_content(@chain.price)
  end
end