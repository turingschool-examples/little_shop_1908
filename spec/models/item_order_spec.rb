require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe 'validations' do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :order_id }
  end
  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :order }
  end

  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @order= Order.create(name: "name", address: "123 a street", city: "city", state: "co", zip: "80232", grand_total: 200, verification: Order.generate_code)
    @item_order_1 = ItemOrder.create( item_id: "#{@tire.id}", order_id: "#{@order.id}", quantity: 2, subtotal: 200)
    @item_order_2 = ItemOrder.create( item_id: "#{@chain.id}", order_id: "#{@order.id}", quantity: 3, subtotal: 150)
  end

  it 'can find an item in the item order' do
    expect(@item_order_1.current_item).to eq(@tire)
  end
end
