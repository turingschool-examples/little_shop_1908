require 'rails_helper'

RSpec.describe Order do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many :item_orders }
    it { should have_many :items }
  end 

  describe 'attributes' do
    @order = Order.create(name: 'Mary', address: '42 Wallaby Way', city: 'Denver', state: 'CO', zip: '80202')
    it 'has attributes' do
      expect(@order.name).to eq('Mary')
      expect(@order.address).to eq('42 Wallaby Way')
      expect(@order.city).to eq('Denver')
      expect(@order.state).to eq('CO')
      expect(@order.zip).to eq('80202')
    end
  end
end
