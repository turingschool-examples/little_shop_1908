require 'rails_helper'

RSpec.describe Cart, type: :model do

  describe '#total_count' do
    it 'can calculate the total number of items' do
      cart = Cart.new({'1' => 2, '2' => 3})

      expect(cart.total_count).to eq(5)
    end
  end

  describe '#add_item' do
    it 'can add an item to contents' do
      cart = Cart.new({'1' => 2, '2' => 3})

      cart.add_item(1)
      cart.add_item(2)
      cart.add_item(3)

      expect(cart.contents).to eq({'1' => 3, '2' => 4, '3' => 1})
    end
  end

  describe '#count_of' do
    it 'returns the count of a specific item' do
      cart = Cart.new({'1' => 2, '2' => 3})

      expect(cart.count_of(1)).to eq(2)
    end
  end

  describe '#subtotal' do
    it 'returns the subtotal of a specific item' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)


      cart = Cart.new({"#{@tire.id}" => 2})

      expect(cart.subtotal(@tire.id)).to eq(200)
    end
  end
end
