require 'rails_helper'

describe 'User fills in order form and clicks Place Order' do
  it "can create item_orders from contents" do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{pull_toy.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'
    visit '/cart'
    click_link 'Checkout'

    name = "Sal"
    address = '123 Kindalikeapizza Dr.'
    city = "Denver"
    state = "CO"
    zip = 80204

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Place Order"

    order = Order.last
    last_2 = ItemOrder.last(2)

    expect(last_2[0].order_id).to eq(order.id)
    expect(last_2[0].item_id).to eq(pull_toy.id)
    expect(last_2[0].quantity).to eq(1)
    expect(last_2[0].total_cost).to eq(52)

    expect(last_2[1].order_id).to eq(order.id)
    expect(last_2[1].item_id).to eq(dog_bone.id)
    expect(last_2[1].quantity).to eq(2)
    expect(last_2[1].total_cost).to eq(52)
  end
end
