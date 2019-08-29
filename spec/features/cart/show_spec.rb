require 'rails_helper'

describe 'Cart Show Page' do
  before :each do
    @merchant_1 = Merchant.create(name: 'Pie Shop', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80001)
    @merchant_2 = Merchant.create(name: 'Donut Shop', address: '321 Main St', city: 'Denver', state: 'CO', zip: 80233)
    @pie = @merchant_1.items.create(name: 'Pie', description: "Yummy Pie!", price: 15, image:"https://images-na.ssl-images-amazon.com/images/I/511RQsDqUgL._SX522_.jpg", inventory: 2 )
    @donut = @merchant_2.items.create(name: 'Donut', description: "Delicious Donut!", price: 3, image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Glazed-Donut.jpg/1920px-Glazed-Donut.jpg(364 kB)https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Glazed-Donut.jpg/1920px-Glazed-Donut.jpg', inventory: 10 )
    @scott = Merchant.create!(name: 'scotts games', address: '842 g st', city: 'Denver', state: 'CO', zip: 80011)
    @vg_1 = @scott.items.create!(name: 'halo 3', description: "Halo 3 for XBOX360", price: 40, image: 'https://images-na.ssl-images-amazon.com/images/I/81JHQU3xX-L._SY679_.jpg', active?: true, inventory: 5 )
    @vg_2 = @scott.items.create!(name: 'smash bros', description: "Smash for wii ", price: 50, image: 'https://images-na.ssl-images-amazon.com/images/I/81aJ-R4E6gL._AC_SX430_.jpg', active?: true, inventory: 1 )
  end

  it 'it shows all items and each item displays the name, image, merchant, price, quantity, subtotal, and grand total' do
    visit "/items"
    within("#item-#{@pie.id}") do
      click_button 'Add Item'
    end
    visit '/cart'

    within "#item-#{@pie.id}" do
      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@pie.name)
      expect(page).to have_css("img[src*='#{@pie.image}']")
      expect(page).to have_content("Sold by: #{@merchant_1.name}")
      expect(page).to have_content("Price: $#{(@pie.price)}")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Subtotal: $#{(@pie.price)}")
    end
    expect(page).to have_content("Total: $#{((@pie.price))}")
  end

  it "I can view my cart when it is empty" do
    visit '/cart'
    expect(page).to have_content('Your Cart is Empty')
    expect(page).to_not have_button('Empty Cart')
  end

  it 'I can empty my cart' do
    visit "/items"
    within("#item-#{@pie.id}") do
      click_button 'Add Item'
    end
    visit '/cart'
    click_button 'Empty Cart'
    expect(current_path).to eq('/cart')
    expect(page).to have_content('Your Cart is Empty')
    expect(page).to have_content('Cart: 0')
    expect(page).to_not have_button('Empty Cart')
  end

  it 'I see a link to remove an item from the cart' do
    visit "/items/#{@vg_1.id}"
    click_button 'Add Item'
    visit "/items/#{@vg_2.id}"
    click_button 'Add Item'
    visit '/cart'
    within "#item-#{@vg_2.id}" do
      click_button "Remove from cart"
    end
    expect(page).to have_content("Cart: 1")
    expect(page).to have_content("#{@vg_1.name}")
    expect(page).to have_content("#{@vg_1.price}")
  end

  it 'I can add item quantity from within my cart' do
    visit "/items/#{@vg_1.id}"
    click_button 'Add Item'

    visit '/cart'

    within "#item-#{@vg_1.id}" do
      click_button('Add More')
    end

    expect(current_path).to eq('/cart')
    within "#item-#{@vg_1.id}" do
      expect(page).to have_content('Quantity: 2')
    end
  end

  it 'I cannot add more items than the items inventory' do
     visit "/items/#{@vg_2.id}"
     click_button 'Add Item'
     visit "/items/#{@vg_2.id}"
     click_button 'Add Item'

     expect(page).to have_content("There is no more inventory for this item")
   end

  it 'I can reduce the quantity of an item in my cart' do
    visit "/items/#{@vg_1.id}"
    click_button 'Add Item'
    visit "/items/#{@vg_1.id}"
    click_button 'Add Item'

    visit '/cart'

    within "#item-#{@vg_1.id}" do
      click_button('Remove One')
    end

    expect(current_path).to eq('/cart')

    within "#item-#{@vg_1.id}" do
      expect(page).to have_content('Quantity: 1')
    end
  end

  it 'the item is removed from my cart if I reduce the quantity to zero' do
    visit "/items/#{@vg_1.id}"
    click_button 'Add Item'

    visit '/cart'

    within "#item-#{@vg_1.id}" do
      click_button('Remove One')
    end

    expect(current_path).to eq('/cart')
    expect(page).to_not have_content("#{@vg_1.name}")
    expect(page).to have_content("Cart: 0")
  end

  it 'I see a button to checkout' do
        visit "/items/#{@vg_1.id}"
        click_button 'Add Item'

        visit "/items/#{@vg_2.id}"
        click_button 'Add Item'

        visit '/cart'

        click_button "Checkout"
        expect(current_path).to eq('/orders/new')
      end
end
