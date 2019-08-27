require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe "relationships" do
    it {should belong_to :order}
    it {should belong_to :item}
  end
  describe "validations" do
    it { should validate_presence_of :subtotal }
    it { should validate_presence_of :quantity}
  end
end
