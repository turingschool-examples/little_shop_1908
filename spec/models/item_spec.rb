require 'rails_helper'

describe Item do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :reviews}
    it { should have_many :item_orders}
    it { should have_many(:orders).through(:item_orders) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :price }
    it { should validate_presence_of :image }
    it { should validate_numericality_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end
end
