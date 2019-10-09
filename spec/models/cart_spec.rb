require 'rails_helper'

RSpec.describe Cart do
  before(:each) do
    @items_hash = {'item_1' => 4, 'item_2' => 5, 'item_3' => 3}
    @cart = Cart.new(@items_hash)
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(@cart.contents).to eq({'item_1' => 4, 'item_2' => 5, 'item_3' => 3})
    end
  end

  describe 'instance methods' do
    it 'can calculate total items' do
      expect(@cart.total_count).to eq(12)
    end
  end
end
