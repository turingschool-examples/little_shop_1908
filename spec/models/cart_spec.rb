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

end
