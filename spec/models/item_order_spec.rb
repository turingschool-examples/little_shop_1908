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

  it 'can find an item' do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    order= Order.create(name: "name", address: "123 a street", city: "city", state: "co", zip: "80232", grand_total: 200)
    item_order = ItemOrder.create( item_id: "#{tire.id}", order_id: "#{order.id}", quantity: 2, subtotal: 200)
    expect(item_order.current_item).to eq(tire)
  end
end
