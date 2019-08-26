require 'rails_helper'

describe Order do
  describe "relationships" do
    it { should have_many :item_orders }
    it { should have_many(:items).through(:item_orders) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_numericality_of :zip }
  end
end
