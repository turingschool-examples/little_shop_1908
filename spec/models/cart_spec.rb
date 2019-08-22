require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({
        1 => 2,  # two copies of item 1
        2 => 3   # three copies of item 2
      })
      expect(cart.total_count).to eq(5)
    end
  end
end
