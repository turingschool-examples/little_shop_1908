require 'rails_helper'

RSpec.describe Order do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:items).through(:order_items)}
  end

  describe 'Validations' do
    it { should validate_presence_of :username}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zipcode}
  end
end
