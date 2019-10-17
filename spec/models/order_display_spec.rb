require 'rails_helper'

RSpec.describe OrderDisplay, type: :model do

  before :each do
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 15, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    @user = User.create(name: 'Steve Spruce', address: '456 2nd Street', city: 'Redville', state: 'SC', zip: '29444')
    @order = @user.orders.create(grand_total: 50, verification_code: '3206758493')
    @order.item_orders.create(item_id: @pull_toy.id, item_quantity: 2, subtotal: 30)
    @order.item_orders.create(item_id: @dog_bone.id, item_quantity: 1, subtotal: 20)

    @order_display = OrderDisplay.new(@order.id)
  end

  it 'initializes correctly' do
    expect(@order_display.order_id).to eq(@order.id)
    expect(@order_display.order).to eq(@order)
  end

  it 'can output a collection of items' do
    expect(@order_display.items).to eq([@pull_toy, @dog_bone])
  end

  it 'can output the quantity of an item in the order' do
    expect(@order_display.quantity_of_item(@pull_toy.id)).to eq(2)
    expect(@order_display.quantity_of_item(@dog_bone.id)).to eq(1)
  end

  it 'can output the subtotal of an item in the order' do
    expect(@order_display.subtotal_of_item(@pull_toy.id)).to eq(30)
    expect(@order_display.subtotal_of_item(@dog_bone.id)).to eq(20)
  end

  it 'can output the grand total of the order' do
    expect(@order_display.grand_total).to eq(50)
  end

  it 'can output the order verification code' do
    expect(@order_display.verification_code).to eq('3206758493')
  end

  it 'can output the order users info' do
    expect(@order_display.user_id).to eq(@user.id)
    expect(@order_display.user_name).to eq('Steve Spruce')
    expect(@order_display.user_address).to eq('456 2nd Street')
    expect(@order_display.user_city).to eq('Redville')
    expect(@order_display.user_state).to eq('SC')
    expect(@order_display.user_zip).to eq('29444')
  end

end
