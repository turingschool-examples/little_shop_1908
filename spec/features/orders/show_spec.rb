require 'rails_helper'

RSpec.describe 'order show page', type: :feature do
  before :each do
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

    visit '/orders/new'

    fill_in 'Name',    with: 'Joe Bob'
    fill_in 'Address', with: '1331 17th Ave'
    fill_in 'City',    with: 'Denver'
    fill_in 'State',   with: 'Colorado'
    fill_in 'zip',     with: '80202'

    click_button 'Create Order'

    @order = Order.last
  end

  it 'displays shipping information' do
    within '#shipping-info' do
      expect(page).to have_content('Joe Bob')
      expect(page).to have_content('1331 17th Ave')
      expect(page).to have_content('Denver')
      expect(page).to have_content('Colorado')
      expect(page).to have_content('80202')
    end
  end

  it 'displays item order information' do
    within "#item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_content("Merchant: #{@tire.merchant.name}")
      expect(page).to have_content("Price: $100.00")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Subtotal: $200.00")
    end

    within "#item-#{@pull_toy.id}" do
      expect(page).to have_content(@pull_toy.name)
      expect(page).to have_content("Merchant: #{@pull_toy.merchant.name}")
      expect(page).to have_content("Price: $10.00")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Subtotal: $10.00")
    end

    within "#item-#{@dog_bone.id}" do
      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_content("Merchant: #{@dog_bone.merchant.name}")
      expect(page).to have_content("Price: $21.00")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Subtotal: $21.00")
    end

    expect(page).to have_content("Grand Total: $231.00")
    expect(page).to have_content("Order Date: #{@order.created_at.to_formatted_s(:long)}")
  end

  it 'cannot go to a order show page that does not exist' do
    visit '/orders/109475'

    expect(current_path).to eq('/cart')
    expect(page).to have_content('Order does not exist!')
  end
end