require 'rails_helper'
describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :item_price }
    it { should validate_presence_of :item_quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end
end
