require 'rails_helper'

RSpec.describe "merchant delete" do

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end

  it "can delete a merchant" do
    visit "merchants/#{@bike_shop.id}"
    click_link "Delete Merchant"

    expect(current_path).to eq('/merchants')
    expect(page).to_not have_content("Brian's Bike Shop")
  end

  it "can delete a merchant that has items" do
    @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "merchants/#{@bike_shop.id}"
    click_link "Delete Merchant"

    expect(current_path).to eq('/merchants')
    expect(page).to_not have_content("Brian's Bike Shop")
  end

  it 'cannot be deleted if merchant has orders' do
    user = User.create(name: 'Kyle Pine', address: '123 Main Street', city: 'Greenville', state: 'NC', zip: '29583')
    order = user.orders.create(grand_total: 100)
    order.item_orders.create(item_id: @chain.id, item_quantity: 2, subtotal: 50)

    visit "/merchants/#{@bike_shop.id}"
    click_link "Delete Merchant"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}")
    expect(page).to have_content('Merchant has orders and cannot be deleted')
  end
  
end
